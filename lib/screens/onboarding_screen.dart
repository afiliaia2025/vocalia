import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/theme.dart';
import '../models/user_profile.dart';

/// Premium multi-step onboarding that configures the app 
/// for the user's specific abilities and communication needs.
class OnboardingScreen extends StatefulWidget {
  final void Function(UserProfile profile) onComplete;
  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Step 1: Name & Age
  final _nameController = TextEditingController();
  int _selectedAge = 8;

  // Step 2: Motor ability
  MotorAbility? _motorAbility;

  // Step 3: Cognitive level
  CognitiveLevel? _cognitiveLevel;

  // Step 4: Communication needs
  final Set<CommunicationNeed> _selectedNeeds = {};

  static const int _totalPages = 4;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool get _canProceed {
    switch (_currentPage) {
      case 0: return _nameController.text.trim().isNotEmpty;
      case 1: return _motorAbility != null;
      case 2: return _cognitiveLevel != null;
      case 3: return _selectedNeeds.isNotEmpty;
      default: return false;
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finish() async {
    final profile = UserProfile.fromOnboarding(
      name: _nameController.text.trim(),
      age: _selectedAge,
      motorAbility: _motorAbility!,
      cognitiveLevel: _cognitiveLevel!,
      communicationNeeds: _selectedNeeds.toList(),
    );

    // Save profile
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile', jsonEncode(profile.toJson()));
    await prefs.setBool('onboarding_complete', true);

    widget.onComplete(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFFEDE7F6),
                    const Color(0xFFE8EAF6),
                    _bgController.value,
                  )!,
                  Color.lerp(
                    const Color(0xFFF3E5F5),
                    const Color(0xFFE0F2F1),
                    _bgController.value,
                  )!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Progress indicator
              _buildProgress(),
              // Pages
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  children: [
                    _buildNamePage(),
                    _buildMotorPage(),
                    _buildCognitivePage(),
                    _buildNeedsPage(),
                  ],
                ),
              ),
              // Navigation buttons
              _buildNavBar(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // PROGRESS BAR
  // ═══════════════════════════════════════════════════════
  Widget _buildProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Row(
        children: List.generate(_totalPages, (i) {
          final active = i <= _currentPage;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: active
                    ? const LinearGradient(
                        colors: [VocaliaTheme.primary, VocaliaTheme.secondary],
                      )
                    : null,
                color: active ? null : Colors.grey.shade300,
              ),
            ),
          );
        }),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // PAGE 1: Name & Age
  // ═══════════════════════════════════════════════════════
  Widget _buildNamePage() {
    return _PageWrapper(
      emoji: '👋',
      title: 'Bienvenido a Vocalia',
      subtitle: '¿Quién va a usar esta app?',
      child: Column(
        children: [
          // Name field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: VocaliaTheme.primary.withAlpha(30),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _nameController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: 'Nombre',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: const Icon(Icons.person_outline, color: VocaliaTheme.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
            ),
          ),
          const SizedBox(height: 28),
          // Age selector
          Text(
            'Edad',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              for (final age in [2, 3, 4, 5, 6, 7, 8, 10, 12, 15, 18, 25, 40, 60, 80])
                _AgeChip(
                  label: age < 18 ? '$age' : '$age+',
                  selected: _selectedAge == age,
                  onTap: () => setState(() => _selectedAge = age),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // PAGE 2: Motor Ability
  // ═══════════════════════════════════════════════════════
  Widget _buildMotorPage() {
    return _PageWrapper(
      emoji: '🤲',
      title: '¿Cómo interactúa ${_nameController.text.isNotEmpty ? _nameController.text : "el usuario"}?',
      subtitle: 'Esto nos ayuda a adaptar el tamaño y los controles',
      child: Column(
        children: [
          _OptionCard(
            emoji: '👆',
            title: 'Toca con precisión',
            subtitle: 'Puede pulsar botones pequeños sin problema',
            selected: _motorAbility == MotorAbility.precise,
            onTap: () => setState(() => _motorAbility = MotorAbility.precise),
          ),
          _OptionCard(
            emoji: '✋',
            title: 'Toca pero no con precisión',
            subtitle: 'Le cuesta acertar en botones pequeños',
            selected: _motorAbility == MotorAbility.imprecise,
            onTap: () => setState(() => _motorAbility = MotorAbility.imprecise),
          ),
          _OptionCard(
            emoji: '📱',
            title: 'Puede mover el teléfono',
            subtitle: 'Puede inclinar o sacudir pero tocar le cuesta mucho',
            selected: _motorAbility == MotorAbility.veryLimited,
            onTap: () => setState(() => _motorAbility = MotorAbility.veryLimited),
          ),
          _OptionCard(
            emoji: '👁️',
            title: 'Solo puede mirar',
            subtitle: 'No puede usar las manos. Necesita eye tracking o barrido',
            selected: _motorAbility == MotorAbility.noTouch,
            onTap: () => setState(() => _motorAbility = MotorAbility.noTouch),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // PAGE 3: Cognitive Level
  // ═══════════════════════════════════════════════════════
  Widget _buildCognitivePage() {
    final name = _nameController.text.isNotEmpty ? _nameController.text : "el usuario";
    return _PageWrapper(
      emoji: '🧠',
      title: '¿Cuánto entiende $name?',
      subtitle: 'Adaptaremos la complejidad de la interfaz',
      child: Column(
        children: [
          _OptionCard(
            emoji: '📚',
            title: 'Entiende bien',
            subtitle: 'Comprende frases, categorías y conceptos abstractos',
            selected: _cognitiveLevel == CognitiveLevel.full,
            onTap: () => setState(() => _cognitiveLevel = CognitiveLevel.full),
          ),
          _OptionCard(
            emoji: '🖼️',
            title: 'Entiende imágenes y palabras simples',
            subtitle: 'Reconoce pictogramas pero necesita simplicidad',
            selected: _cognitiveLevel == CognitiveLevel.moderate,
            onTap: () => setState(() => _cognitiveLevel = CognitiveLevel.moderate),
          ),
          _OptionCard(
            emoji: '⭐',
            title: 'Necesita lo más sencillo posible',
            subtitle: 'Pocos pictogramas, botones muy grandes, sin distracciones',
            selected: _cognitiveLevel == CognitiveLevel.simple,
            onTap: () => setState(() => _cognitiveLevel = CognitiveLevel.simple),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // PAGE 4: Communication Needs
  // ═══════════════════════════════════════════════════════
  Widget _buildNeedsPage() {
    final name = _nameController.text.isNotEmpty ? _nameController.text : "el usuario";
    return _PageWrapper(
      emoji: '💬',
      title: '¿Qué necesita comunicar $name?',
      subtitle: 'Selecciona todo lo que aplique',
      child: Column(
        children: [
          _NeedChip(
            emoji: '🍎',
            label: 'Pedir cosas (comida, agua, juguetes)',
            selected: _selectedNeeds.contains(CommunicationNeed.requestThings),
            onTap: () => setState(() => _selectedNeeds.contains(CommunicationNeed.requestThings)
                ? _selectedNeeds.remove(CommunicationNeed.requestThings)
                : _selectedNeeds.add(CommunicationNeed.requestThings)),
          ),
          _NeedChip(
            emoji: '😊',
            label: 'Expresar emociones (feliz, triste, enfadado)',
            selected: _selectedNeeds.contains(CommunicationNeed.expressEmotions),
            onTap: () => setState(() => _selectedNeeds.contains(CommunicationNeed.expressEmotions)
                ? _selectedNeeds.remove(CommunicationNeed.expressEmotions)
                : _selectedNeeds.add(CommunicationNeed.expressEmotions)),
          ),
          _NeedChip(
            emoji: '🤕',
            label: 'Expresar dolor (dónde duele, cuánto)',
            selected: _selectedNeeds.contains(CommunicationNeed.expressPain),
            onTap: () => setState(() => _selectedNeeds.contains(CommunicationNeed.expressPain)
                ? _selectedNeeds.remove(CommunicationNeed.expressPain)
                : _selectedNeeds.add(CommunicationNeed.expressPain)),
          ),
          _NeedChip(
            emoji: '📖',
            label: 'Contar experiencias (qué hizo en el cole)',
            selected: _selectedNeeds.contains(CommunicationNeed.tellExperiences),
            onTap: () => setState(() => _selectedNeeds.contains(CommunicationNeed.tellExperiences)
                ? _selectedNeeds.remove(CommunicationNeed.tellExperiences)
                : _selectedNeeds.add(CommunicationNeed.tellExperiences)),
          ),
          _NeedChip(
            emoji: '👋',
            label: 'Saludar, despedirse, interacción social',
            selected: _selectedNeeds.contains(CommunicationNeed.socialChat),
            onTap: () => setState(() => _selectedNeeds.contains(CommunicationNeed.socialChat)
                ? _selectedNeeds.remove(CommunicationNeed.socialChat)
                : _selectedNeeds.add(CommunicationNeed.socialChat)),
          ),
          _NeedChip(
            emoji: '🍽️',
            label: 'Comunicar sobre comidas',
            selected: _selectedNeeds.contains(CommunicationNeed.mealtime),
            onTap: () => setState(() => _selectedNeeds.contains(CommunicationNeed.mealtime)
                ? _selectedNeeds.remove(CommunicationNeed.mealtime)
                : _selectedNeeds.add(CommunicationNeed.mealtime)),
          ),
          _NeedChip(
            emoji: '📅',
            label: 'Seguir rutinas diarias',
            selected: _selectedNeeds.contains(CommunicationNeed.routines),
            onTap: () => setState(() => _selectedNeeds.contains(CommunicationNeed.routines)
                ? _selectedNeeds.remove(CommunicationNeed.routines)
                : _selectedNeeds.add(CommunicationNeed.routines)),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // NAVIGATION BAR
  // ═══════════════════════════════════════════════════════
  Widget _buildNavBar() {
    final isLast = _currentPage == _totalPages - 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          if (_currentPage > 0)
            TextButton.icon(
              onPressed: _prevPage,
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Atrás'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey.shade600,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            )
          else
            const SizedBox(width: 100),
          const Spacer(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: ElevatedButton(
              onPressed: _canProceed ? _nextPage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: VocaliaTheme.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: _canProceed ? 4 : 0,
                shadowColor: VocaliaTheme.primary.withAlpha(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isLast ? 'Empezar' : 'Siguiente',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 8),
                  Icon(isLast ? Icons.rocket_launch_rounded : Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// REUSABLE WIDGETS
// ═══════════════════════════════════════════════════════

class _PageWrapper extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Widget child;

  const _PageWrapper({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(emoji, style: const TextStyle(fontSize: 56)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF2D2D3A)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          child,
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: selected ? VocaliaTheme.primary.withAlpha(18) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? VocaliaTheme.primary : Colors.grey.shade200,
                width: selected ? 2.5 : 1.5,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: VocaliaTheme.primary.withAlpha(30),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withAlpha(8),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: selected ? VocaliaTheme.primary : const Color(0xFF2D2D3A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? VocaliaTheme.primary : Colors.grey.shade200,
                  ),
                  child: selected
                      ? const Icon(Icons.check, color: Colors.white, size: 18)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AgeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _AgeChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? VocaliaTheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? VocaliaTheme.primary : Colors.grey.shade300,
            width: selected ? 2 : 1.5,
          ),
          boxShadow: selected
              ? [BoxShadow(color: VocaliaTheme.primary.withAlpha(40), blurRadius: 8, offset: const Offset(0, 2))]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}

class _NeedChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NeedChip({
    required this.emoji,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          width: double.infinity,
          decoration: BoxDecoration(
            color: selected ? VocaliaTheme.primary.withAlpha(15) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? VocaliaTheme.primary : Colors.grey.shade200,
              width: selected ? 2.5 : 1.5,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: selected ? VocaliaTheme.primary : Colors.grey.shade200,
                ),
                child: selected
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
              const SizedBox(width: 14),
              Text(emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? VocaliaTheme.primary : const Color(0xFF2D2D3A),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

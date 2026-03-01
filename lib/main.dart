import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'config/theme.dart';
import 'services/ai_service.dart';
import 'services/tts_service.dart';
import 'providers/board_provider.dart';
import 'screens/board_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VocaliaApp());
}

class VocaliaApp extends StatefulWidget {
  const VocaliaApp({super.key});

  @override
  State<VocaliaApp> createState() => _VocaliaAppState();
}

class _VocaliaAppState extends State<VocaliaApp> {
  final AIService _aiService = AIService();
  final TTSService _ttsService = TTSService();

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    await _ttsService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BoardProvider(
            aiService: _aiService,
            ttsService: _ttsService,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Vocalia',
        debugShowCheckedModeBanner: false,
        theme: VocaliaTheme.lightTheme,
        darkTheme: VocaliaTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const _ApiKeyGate(),
      ),
    );
  }

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }
}

/// Premium API Key gate screen.
class _ApiKeyGate extends StatefulWidget {
  const _ApiKeyGate();

  @override
  State<_ApiKeyGate> createState() => _ApiKeyGateState();
}

class _ApiKeyGateState extends State<_ApiKeyGate>
    with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  bool _loading = false;
  bool _skipped = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_skipped) return const BoardScreen();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF0F0F1A), const Color(0xFF1A1035), const Color(0xFF0F0F1A)]
                : [const Color(0xFFF5F3FF), const Color(0xFFE8E0FF), const Color(0xFFF0E6FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ─── Animated Logo ───
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            gradient: VocaliaTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: VocaliaTheme.primary.withAlpha(
                                  (40 + (_pulseController.value * 40)).toInt(),
                                ),
                                blurRadius: 30 + (_pulseController.value * 20),
                                spreadRadius: _pulseController.value * 4,
                                offset: const Offset(0, 8),
                              ),
                              BoxShadow(
                                color: VocaliaTheme.secondary.withAlpha(
                                  (20 + (_pulseController.value * 20)).toInt(),
                                ),
                                blurRadius: 40,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text('🗣️', style: TextStyle(fontSize: 52)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 28),

                    // ─── Title ───
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          VocaliaTheme.primaryGradient.createShader(bounds),
                      child: Text(
                        'Vocalia',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tu voz, con inteligencia',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isDark
                            ? VocaliaTheme.textDarkSecondary
                            : VocaliaTheme.textSecondary,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // ─── Feature Pills ───
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _FeaturePill(icon: '🤖', label: 'IA Generativa', isDark: isDark),
                        _FeaturePill(icon: '🔊', label: 'Voz Natural', isDark: isDark),
                        _FeaturePill(icon: '♿', label: 'Accesible', isDark: isDark),
                        _FeaturePill(icon: '📱', label: 'Multiplataforma', isDark: isDark),
                      ],
                    ),
                    const SizedBox(height: 36),

                    // ─── API Key Card ───
                    ClipRRect(
                      borderRadius: BorderRadius.circular(VocaliaTheme.radiusLg),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withAlpha(10)
                                : Colors.white.withAlpha(200),
                            borderRadius:
                                BorderRadius.circular(VocaliaTheme.radiusLg),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withAlpha(12)
                                  : VocaliaTheme.primary.withAlpha(20),
                            ),
                            boxShadow: VocaliaTheme.softShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: VocaliaTheme.primary.withAlpha(20),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text('🔑', style: TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'API Key de Gemini',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Activa la inteligencia artificial para generar frases naturales a partir de pictogramas.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: isDark
                                          ? VocaliaTheme.textDarkSecondary
                                          : VocaliaTheme.textSecondary,
                                      height: 1.4,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: _controller,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'AIzaSy...',
                                  filled: true,
                                  fillColor: isDark
                                      ? Colors.white.withAlpha(8)
                                      : VocaliaTheme.bgLight,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(Icons.key_rounded,
                                      size: 20),
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 14),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Submit button
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: GestureDetector(
                                  onTap: _loading ? null : _onSubmit,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: VocaliaTheme.speakButtonGradient,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: VocaliaTheme.primary
                                              .withAlpha(60),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: _loading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child:
                                                CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white),
                                          )
                                        : const Text(
                                            'Activar IA ✨',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Skip button
                    GestureDetector(
                      onTap: () => setState(() => _skipped = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withAlpha(8)
                              : Colors.white.withAlpha(150),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withAlpha(10)
                                : Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.skip_next_rounded,
                                size: 18,
                                color: isDark
                                    ? VocaliaTheme.textDarkSecondary
                                    : VocaliaTheme.textSecondary),
                            const SizedBox(width: 6),
                            Text(
                              'Continuar sin IA (modo básico)',
                              style: TextStyle(
                                color: isDark
                                    ? VocaliaTheme.textDarkSecondary
                                    : VocaliaTheme.textSecondary,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    final key = _controller.text.trim();
    if (key.isEmpty) return;

    setState(() => _loading = true);

    setState(() {
      _loading = false;
      _skipped = true;
    });

    if (mounted) {
      final boardProvider = context.read<BoardProvider>();
      boardProvider.initializeAI(key);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }
}

class _FeaturePill extends StatelessWidget {
  final String icon;
  final String label;
  final bool isDark;

  const _FeaturePill({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withAlpha(8)
            : Colors.white.withAlpha(180),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withAlpha(8)
              : VocaliaTheme.primary.withAlpha(15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : VocaliaTheme.textPrimary,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

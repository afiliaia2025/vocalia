import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../config/theme.dart';
import '../models/pictogram.dart';
import '../providers/board_provider.dart';
import 'settings_screen.dart';
import 'history_screen.dart';

/// Main communication board screen — the heart of Vocalia.
/// Premium, animated, glassmorphism-inspired design.
class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF0F0F1A), const Color(0xFF1A1035), const Color(0xFF0F0F1A)]
                : [const Color(0xFFF5F3FF), const Color(0xFFEDE7FF), const Color(0xFFF0E6FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ─── App Bar ───
              const _VocaliaAppBar(),
              const SizedBox(height: 4),
              // ─── Phrase Bar ───
              const _PhraseBar(),
              const SizedBox(height: 12),
              // ─── Category Tabs ───
              const _CategoryTabs(),
              const SizedBox(height: 8),
              // ─── Pictogram Grid ───
              const Expanded(child: _PictogramGrid()),
              // ─── Action Buttons ───
              const _ActionBar(),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// APP BAR — Premium gradient branding
// ═══════════════════════════════════════════════════════
class _VocaliaAppBar extends StatelessWidget {
  const _VocaliaAppBar();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Animated logo
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: VocaliaTheme.primaryGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: VocaliaTheme.primary.withAlpha(60),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text('🗣️', style: TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => VocaliaTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    'Vocalia',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Text(
                  'Tu voz, con inteligencia',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
                    fontSize: 11,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          // History button
          _AppBarButton(
            icon: Icons.history_rounded,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
            isDark: isDark,
          ),
          const SizedBox(width: 6),
          // Settings button
          _AppBarButton(
            icon: Icons.tune_rounded,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;
  const _AppBarButton({required this.icon, required this.onTap, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? Colors.white.withAlpha(10) : Colors.white.withAlpha(180),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(icon, size: 20, color: isDark ? Colors.white70 : VocaliaTheme.textSecondary),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// PHRASE BAR — Glassmorphism, glowing when active
// ═══════════════════════════════════════════════════════
class _PhraseBar extends StatelessWidget {
  const _PhraseBar();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(VocaliaTheme.radiusLg),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(minHeight: 72),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withAlpha(board.hasSelection ? 15 : 8)
                  : Colors.white.withAlpha(board.hasSelection ? 220 : 180),
              borderRadius: BorderRadius.circular(VocaliaTheme.radiusLg),
              border: Border.all(
                color: board.hasSelection
                    ? VocaliaTheme.primary.withAlpha(board.generatedText != null ? 100 : 60)
                    : (isDark ? Colors.white.withAlpha(10) : Colors.white.withAlpha(100)),
                width: board.hasSelection ? 2 : 1,
              ),
              boxShadow: board.hasSelection ? VocaliaTheme.glowShadow : VocaliaTheme.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (board.hasSelection) ...[
                  // Selected pictograms as chips
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: board.selectedPictograms.length,
                      separatorBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(Icons.chevron_right_rounded, size: 16,
                          color: VocaliaTheme.primary.withAlpha(100)),
                      ),
                      itemBuilder: (context, index) {
                        final p = board.selectedPictograms[index];
                        return _SelectedPictogramChip(pictogram: p);
                      },
                    ),
                  ),
                ],
                if (board.generatedText != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          board.generatedText!,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                            foreground: Paint()
                              ..shader = VocaliaTheme.primaryGradient.createShader(
                                const Rect.fromLTWH(0, 0, 300, 30)),
                          ),
                        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.15, end: 0),
                      ),
                      const SizedBox(width: 8),
                      _MiniSpeakButton(
                        onPressed: board.speak,
                        isSpeaking: board.isSpeaking,
                      ),
                    ],
                  ),
                ] else if (!board.hasSelection) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app_rounded, size: 18,
                        color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary),
                      const SizedBox(width: 8),
                      Text(
                        'Toca los pictogramas para formar tu frase',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ] else if (board.isGenerating) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: VocaliaTheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Pensando...',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: VocaliaTheme.primary,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedPictogramChip extends StatelessWidget {
  final Pictogram pictogram;
  const _SelectedPictogramChip({required this.pictogram});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [VocaliaTheme.primary.withAlpha(20), VocaliaTheme.secondary.withAlpha(15)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: VocaliaTheme.primary.withAlpha(40)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(pictogram.emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 4),
          Text(
            pictogram.label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: VocaliaTheme.primaryDark,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    ).animate().scale(
      begin: const Offset(0.5, 0.5),
      end: const Offset(1, 1),
      duration: 200.ms,
      curve: Curves.easeOutBack,
    );
  }
}

class _MiniSpeakButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSpeaking;
  const _MiniSpeakButton({required this.onPressed, required this.isSpeaking});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: isSpeaking
              ? const LinearGradient(colors: [VocaliaTheme.secondary, VocaliaTheme.secondaryDark])
              : VocaliaTheme.primaryGradient,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: (isSpeaking ? VocaliaTheme.secondary : VocaliaTheme.primary).withAlpha(50),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          isSpeaking ? Icons.stop_rounded : Icons.volume_up_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// CATEGORY TABS — Color-coded, pill shape, scrollable
// ═══════════════════════════════════════════════════════
class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: board.categories.length,
        itemBuilder: (context, index) {
          final cat = board.categories[index];
          final isActive = cat.id == board.activeCategory;
          final catColor = VocaliaTheme.categoryColors[index % VocaliaTheme.categoryColors.length];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: GestureDetector(
              onTap: () => board.setCategory(cat.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isActive
                      ? LinearGradient(colors: [catColor, catColor.withAlpha(200)])
                      : null,
                  color: isActive
                      ? null
                      : (isDark ? Colors.white.withAlpha(8) : Colors.white.withAlpha(150)),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isActive ? catColor.withAlpha(0) : (isDark ? Colors.white10 : Colors.white),
                    width: 1,
                  ),
                  boxShadow: isActive
                      ? [BoxShadow(color: catColor.withAlpha(60), blurRadius: 12, offset: const Offset(0, 4))]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(cat.emoji, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    Text(
                      cat.name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                        color: isActive
                            ? Colors.white
                            : (isDark ? Colors.white60 : VocaliaTheme.textSecondary),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// PICTOGRAM GRID — Premium cards with color tint
// ═══════════════════════════════════════════════════════
class _PictogramGrid extends StatelessWidget {
  const _PictogramGrid();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final pictograms = board.currentCategoryPictograms;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive columns
    final crossAxisCount = screenWidth < 400 ? 3 : (screenWidth < 600 ? 3 : (screenWidth < 900 ? 4 : 6));
    // Get current category index for color
    final catIndex = board.categories.indexWhere((c) => c.id == board.activeCategory);
    final catColor = VocaliaTheme.categoryColors[catIndex.clamp(0, VocaliaTheme.categoryColors.length - 1)];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: pictograms.length,
      itemBuilder: (context, index) {
        return _PictogramButton(
          pictogram: pictograms[index],
          categoryColor: catColor,
          onTap: () => board.addPictogram(pictograms[index]),
        ).animate()
          .fadeIn(duration: 200.ms, delay: Duration(milliseconds: (50 * index).clamp(0, 300)))
          .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1), duration: 250.ms, delay: Duration(milliseconds: (50 * index).clamp(0, 300)));
      },
    );
  }
}

class _PictogramButton extends StatefulWidget {
  final Pictogram pictogram;
  final Color categoryColor;
  final VoidCallback onTap;

  const _PictogramButton({
    required this.pictogram,
    required this.categoryColor,
    required this.onTap,
  });

  @override
  State<_PictogramButton> createState() => _PictogramButtonState();
}

class _PictogramButtonState extends State<_PictogramButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final catColor = widget.categoryColor;

    return Semantics(
      label: widget.pictogram.label,
      button: true,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.92 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              gradient: _isPressed
                  ? LinearGradient(
                      colors: [catColor.withAlpha(40), catColor.withAlpha(20)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: isDark
                          ? [Colors.white.withAlpha(10), Colors.white.withAlpha(5)]
                          : [Colors.white.withAlpha(240), Colors.white.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
              border: Border.all(
                color: _isPressed
                    ? catColor.withAlpha(150)
                    : (isDark ? Colors.white.withAlpha(8) : Colors.white.withAlpha(200)),
                width: _isPressed ? 2 : 1,
              ),
              boxShadow: [
                if (_isPressed)
                  BoxShadow(
                    color: catColor.withAlpha(40),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  )
                else
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 15 : 8),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Emoji with subtle background circle
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: catColor.withAlpha(isDark ? 20 : 15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      widget.pictogram.emoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    widget.pictogram.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white.withAlpha(200) : VocaliaTheme.textPrimary,
                      letterSpacing: 0.1,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// ACTION BAR — Premium glassmorphism bottom bar
// ═══════════════════════════════════════════════════════
class _ActionBar extends StatelessWidget {
  const _ActionBar();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withAlpha(60)
                : Colors.white.withAlpha(200),
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.white.withAlpha(8) : VocaliaTheme.primary.withAlpha(15),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Clear button
              _ActionButton(
                icon: Icons.delete_outline_rounded,
                label: 'Borrar',
                color: VocaliaTheme.error,
                isDark: isDark,
                onPressed: board.hasSelection ? board.clearSelection : null,
              ),
              const SizedBox(width: 8),
              // Backspace button
              _ActionButton(
                icon: Icons.backspace_outlined,
                label: 'Atrás',
                color: VocaliaTheme.warning,
                isDark: isDark,
                onPressed: board.hasSelection ? board.removeLastPictogram : null,
              ),
              const SizedBox(width: 12),
              // SPEAK button
              Expanded(
                child: _SpeakButton(
                  onPressed: board.hasSelection
                      ? () => board.generateAndSpeak()
                      : null,
                  isGenerating: board.isGenerating,
                  isSpeaking: board.isSpeaking,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;

    return Material(
      color: enabled
          ? color.withAlpha(isDark ? 30 : 15)
          : (isDark ? Colors.white.withAlpha(5) : Colors.grey.shade50),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: Container(
          width: 62,
          height: 56,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: enabled ? color : Colors.grey.shade400, size: 22),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: enabled ? color : Colors.grey.shade400,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpeakButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isGenerating;
  final bool isSpeaking;

  const _SpeakButton({
    this.onPressed,
    required this.isGenerating,
    required this.isSpeaking,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 56,
        decoration: BoxDecoration(
          gradient: enabled
              ? (isSpeaking
                  ? const LinearGradient(colors: [VocaliaTheme.secondary, VocaliaTheme.secondaryDark])
                  : VocaliaTheme.speakButtonGradient)
              : null,
          color: enabled ? null : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(18),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: (isSpeaking ? VocaliaTheme.secondary : VocaliaTheme.primary).withAlpha(80),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isGenerating)
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
              )
            else
              Icon(
                isSpeaking ? Icons.stop_rounded : Icons.campaign_rounded,
                color: enabled ? Colors.white : Colors.grey.shade500,
                size: 26,
              ),
            const SizedBox(width: 8),
            Text(
              isGenerating
                  ? 'Pensando...'
                  : (isSpeaking ? 'Parar' : 'Hablar'),
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: enabled ? Colors.white : Colors.grey.shade500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

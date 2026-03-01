import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../models/pictogram.dart';
import '../providers/board_provider.dart';

/// Main communication board screen — the heart of Vocalia.
class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ─── App Bar ───
            const _VocaliaAppBar(),
            // ─── Phrase Bar (shows selected pictograms + generated text) ───
            const _PhraseBar(),
            const SizedBox(height: 8),
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
    );
  }
}

// ═══════════════════════════════════════════════════════
// APP BAR
// ═══════════════════════════════════════════════════════
class _VocaliaAppBar extends StatelessWidget {
  const _VocaliaAppBar();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [VocaliaTheme.primary, VocaliaTheme.secondary],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '🗣️',
              style: TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vocalia',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [VocaliaTheme.primary, VocaliaTheme.secondary],
                    ).createShader(const Rect.fromLTWH(0, 0, 120, 30)),
                ),
              ),
              Text(
                'Tu voz, con inteligencia',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Settings
          IconButton(
            onPressed: () {
              // TODO: Open settings
            },
            icon: Icon(
              Icons.settings_rounded,
              color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
            ),
            tooltip: 'Ajustes',
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// PHRASE BAR — Shows selected pictograms and generated phrase
// ═══════════════════════════════════════════════════════
class _PhraseBar extends StatelessWidget {
  const _PhraseBar();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(minHeight: 80),
      decoration: BoxDecoration(
        color: isDark ? VocaliaTheme.cardDark : VocaliaTheme.cardLight,
        borderRadius: BorderRadius.circular(VocaliaTheme.radiusLg),
        border: Border.all(
          color: board.hasSelection
              ? VocaliaTheme.primary.withAlpha(100)
              : (isDark ? Colors.white10 : Colors.black12),
          width: 2,
        ),
        boxShadow: board.hasSelection
            ? [
                BoxShadow(
                  color: VocaliaTheme.primary.withAlpha(30),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (board.hasSelection) ...[
            // Selected pictograms row
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: board.selectedPictograms.length,
                separatorBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.arrow_forward_rounded, size: 16, color: VocaliaTheme.textSecondary),
                ),
                itemBuilder: (context, index) {
                  final p = board.selectedPictograms[index];
                  return _SelectedPictogramChip(pictogram: p, index: index);
                },
              ),
            ),
          ],
          if (board.generatedText != null) ...[
            const SizedBox(height: 12),
            // Generated phrase
            Row(
              children: [
                Expanded(
                  child: Text(
                    board.generatedText!,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: VocaliaTheme.primary,
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
                ),
                const SizedBox(width: 8),
                // Quick speak button on the phrase
                _SpeakIconButton(
                  onPressed: board.speak,
                  isSpeaking: board.isSpeaking,
                ),
              ],
            ),
          ] else if (!board.hasSelection) ...[
            // Empty state
            Center(
              child: Text(
                'Toca los pictogramas para formar tu frase',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ] else if (board.isGenerating) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: VocaliaTheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Generando frase...',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: VocaliaTheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SelectedPictogramChip extends StatelessWidget {
  final Pictogram pictogram;
  final int index;
  const _SelectedPictogramChip({required this.pictogram, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: VocaliaTheme.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(VocaliaTheme.radiusSm),
        border: Border.all(color: VocaliaTheme.primary.withAlpha(60)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(pictogram.emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 4),
          Text(
            pictogram.label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: VocaliaTheme.primaryDark,
            ),
          ),
        ],
      ),
    ).animate().scale(
      begin: const Offset(0, 0),
      end: const Offset(1, 1),
      duration: 200.ms,
      curve: Curves.easeOutBack,
    );
  }
}

class _SpeakIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSpeaking;
  const _SpeakIconButton({required this.onPressed, required this.isSpeaking});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSpeaking ? VocaliaTheme.secondary : VocaliaTheme.primary,
      borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
      child: InkWell(
        borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
        onTap: onPressed,
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Icon(
            isSpeaking ? Icons.stop_rounded : Icons.volume_up_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// CATEGORY TABS
// ═══════════════════════════════════════════════════════
class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 56,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: board.categories.length,
        itemBuilder: (context, index) {
          final cat = board.categories[index];
          final isActive = cat.id == board.activeCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Material(
              color: isActive
                  ? VocaliaTheme.primary
                  : (isDark ? VocaliaTheme.cardDark : Colors.grey.shade100),
              borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
              elevation: isActive ? 4 : 0,
              shadowColor: VocaliaTheme.primary.withAlpha(80),
              child: InkWell(
                borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
                onTap: () => board.setCategory(cat.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Text(cat.emoji, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 6),
                      Text(
                        cat.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isActive
                              ? Colors.white
                              : (isDark ? VocaliaTheme.textDark : VocaliaTheme.textPrimary),
                        ),
                      ),
                    ],
                  ),
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
// PICTOGRAM GRID
// ═══════════════════════════════════════════════════════
class _PictogramGrid extends StatelessWidget {
  const _PictogramGrid();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final pictograms = board.currentCategoryPictograms;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive: 3 columns on mobile, 4 on tablet, 6 on desktop
    final crossAxisCount = screenWidth < 600 ? 3 : (screenWidth < 900 ? 4 : 6);

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: pictograms.length,
      itemBuilder: (context, index) {
        return _PictogramButton(
          pictogram: pictograms[index],
          onTap: () => board.addPictogram(pictograms[index]),
        );
      },
    );
  }
}

class _PictogramButton extends StatefulWidget {
  final Pictogram pictogram;
  final VoidCallback onTap;

  const _PictogramButton({
    required this.pictogram,
    required this.onTap,
  });

  @override
  State<_PictogramButton> createState() => _PictogramButtonState();
}

class _PictogramButtonState extends State<_PictogramButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          scale: _isPressed ? 0.9 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: _isPressed
                  ? VocaliaTheme.primary.withAlpha(30)
                  : (isDark ? VocaliaTheme.cardDark : VocaliaTheme.cardLight),
              borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
              border: Border.all(
                color: _isPressed
                    ? VocaliaTheme.primary
                    : (isDark ? Colors.white10 : Colors.grey.shade200),
                width: _isPressed ? 2.5 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isPressed
                      ? VocaliaTheme.primary.withAlpha(40)
                      : Colors.black.withAlpha(isDark ? 20 : 10),
                  blurRadius: _isPressed ? 12 : 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.pictogram.emoji,
                  style: const TextStyle(fontSize: 36),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.pictogram.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? VocaliaTheme.textDark : VocaliaTheme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
// ACTION BAR — Speak, Clear, Backspace
// ═══════════════════════════════════════════════════════
class _ActionBar extends StatelessWidget {
  const _ActionBar();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? VocaliaTheme.surfaceDark : VocaliaTheme.surfaceLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 40 : 15),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Clear button
          _ActionButton(
            icon: Icons.delete_outline_rounded,
            label: 'Borrar',
            color: VocaliaTheme.error,
            onPressed: board.hasSelection ? board.clearSelection : null,
          ),
          const SizedBox(width: 8),
          // Backspace button
          _ActionButton(
            icon: Icons.backspace_outlined,
            label: 'Atrás',
            color: VocaliaTheme.warning,
            onPressed: board.hasSelection ? board.removeLastPictogram : null,
          ),
          const SizedBox(width: 12),
          // SPEAK button — the star of the show
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
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: enabled
          ? color.withAlpha(isDark ? 40 : 25)
          : (isDark ? Colors.white.withAlpha(5) : Colors.grey.shade100),
      borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
      child: InkWell(
        borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
        onTap: onPressed,
        child: Container(
          width: VocaliaTheme.minTouchTarget,
          height: VocaliaTheme.minTouchTarget,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: enabled ? color : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: enabled ? color : Colors.grey,
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(VocaliaTheme.radiusLg),
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: VocaliaTheme.minTouchTarget,
          decoration: BoxDecoration(
            gradient: enabled
                ? const LinearGradient(
                    colors: [VocaliaTheme.primary, VocaliaTheme.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: enabled ? null : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(VocaliaTheme.radiusLg),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: VocaliaTheme.primary.withAlpha(80),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
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
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              else
                Icon(
                  isSpeaking ? Icons.stop_rounded : Icons.campaign_rounded,
                  color: enabled ? Colors.white : Colors.grey,
                  size: 28,
                ),
              const SizedBox(width: 8),
              Text(
                isGenerating
                    ? 'Pensando...'
                    : (isSpeaking ? 'Parar' : 'Hablar'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: enabled ? Colors.white : Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

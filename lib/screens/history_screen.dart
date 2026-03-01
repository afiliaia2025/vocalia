import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../providers/board_provider.dart';
import '../models/phrase.dart';

/// History & Favorites screen.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.history_rounded), text: 'Recientes'),
            Tab(icon: Icon(Icons.star_rounded), text: 'Favoritos'),
          ],
          indicatorColor: VocaliaTheme.primary,
          labelColor: VocaliaTheme.primary,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _RecentTab(),
          _FavoritesTab(),
        ],
      ),
    );
  }
}

class _RecentTab extends StatelessWidget {
  const _RecentTab();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final history = board.history;

    if (history.isEmpty) {
      return _EmptyState(
        icon: Icons.history_rounded,
        title: 'Sin historial',
        subtitle: 'Las frases generadas aparecerán aquí',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: history.length,
      itemBuilder: (context, index) {
        return _PhraseCard(
          phrase: history[index],
          onTap: () {
            board.loadPhrase(history[index]);
            Navigator.pop(context);
          },
          onFavorite: () => board.toggleFavorite(history[index]),
          onSpeak: () => board.speak(),
        );
      },
    );
  }
}

class _FavoritesTab extends StatelessWidget {
  const _FavoritesTab();

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardProvider>();
    final favorites = board.favorites;

    if (favorites.isEmpty) {
      return _EmptyState(
        icon: Icons.star_border_rounded,
        title: 'Sin favoritos',
        subtitle: 'Marca frases como favoritas para encontrarlas rápido',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return _PhraseCard(
          phrase: favorites[index],
          onTap: () {
            board.loadPhrase(favorites[index]);
            Navigator.pop(context);
          },
          onFavorite: () => board.toggleFavorite(favorites[index]),
          onSpeak: () => board.speak(),
        );
      },
    );
  }
}

class _PhraseCard extends StatelessWidget {
  final GeneratedPhrase phrase;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final VoidCallback onSpeak;

  const _PhraseCard({
    required this.phrase,
    required this.onTap,
    required this.onFavorite,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: isDark ? VocaliaTheme.cardDark : VocaliaTheme.cardLight,
        borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(VocaliaTheme.radiusMd),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pictogram emojis
                Wrap(
                  spacing: 4,
                  children: phrase.pictograms
                      .map((p) => Text(p.emoji, style: const TextStyle(fontSize: 20)))
                      .toList(),
                ),
                const SizedBox(height: 8),
                // Generated text
                Text(
                  phrase.text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: VocaliaTheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                // Actions row
                Row(
                  children: [
                    Text(
                      _timeAgo(phrase.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        phrase.isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                        color: phrase.isFavorite ? VocaliaTheme.warning : Colors.grey,
                      ),
                      onPressed: onFavorite,
                      tooltip: 'Favorito',
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up_rounded, color: VocaliaTheme.primary),
                      onPressed: () {
                        // Re-load phrase text and speak
                        final board = context.read<BoardProvider>();
                        board.loadPhrase(phrase);
                        board.speak();
                      },
                      tooltip: 'Reproducir',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Ahora';
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Hace ${diff.inHours}h';
    return 'Hace ${diff.inDays}d';
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

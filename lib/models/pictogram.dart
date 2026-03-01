/// Represents a single pictogram in the communication board.
class Pictogram {
  final String id;
  final String label;         // Human-readable label (e.g., "pizza")
  final String emoji;          // Emoji fallback for quick display
  final String? imageUrl;      // Optional: ARASAAC or custom image URL
  final String category;       // Category ID (emotions, food, places, etc.)
  final List<String> keywords; // Keywords for AI context
  final int sortOrder;

  const Pictogram({
    required this.id,
    required this.label,
    required this.emoji,
    this.imageUrl,
    required this.category,
    this.keywords = const [],
    this.sortOrder = 0,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'label': label,
    'emoji': emoji,
    'imageUrl': imageUrl,
    'category': category,
    'keywords': keywords,
    'sortOrder': sortOrder,
  };

  factory Pictogram.fromMap(Map<String, dynamic> map) => Pictogram(
    id: map['id'] as String,
    label: map['label'] as String,
    emoji: map['emoji'] as String,
    imageUrl: map['imageUrl'] as String?,
    category: map['category'] as String,
    keywords: List<String>.from(map['keywords'] ?? []),
    sortOrder: map['sortOrder'] as int? ?? 0,
  );
}

/// A category of pictograms shown as a tab/section.
class PictogramCategory {
  final String id;
  final String name;
  final String emoji;
  final int sortOrder;

  const PictogramCategory({
    required this.id,
    required this.name,
    required this.emoji,
    this.sortOrder = 0,
  });
}

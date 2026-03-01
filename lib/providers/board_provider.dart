import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/pictogram.dart';
import '../models/phrase.dart';
import '../services/ai_service.dart';
import '../services/tts_service.dart';
import '../data/pictogram_data.dart';

/// Central state manager for the communication board.
/// Auto-speak mode: after a short pause, automatically generates and speaks.
class BoardProvider extends ChangeNotifier {
  final AIService _aiService;
  final TTSService _ttsService;

  // ─── Auto-speak debounce ───
  Timer? _autoSpeakTimer;
  static const Duration autoSpeakDelay = Duration(milliseconds: 1800);

  // ─── State ───
  List<Pictogram> _selectedPictograms = [];
  String? _generatedText;
  bool _isGenerating = false;
  bool _isSpeaking = false;
  String _activeCategory = 'basic';
  List<GeneratedPhrase> _history = [];
  List<GeneratedPhrase> _favorites = [];

  // ─── Getters ───
  List<Pictogram> get selectedPictograms => _selectedPictograms;
  String? get generatedText => _generatedText;
  bool get isGenerating => _isGenerating;
  bool get isSpeaking => _isSpeaking;
  String get activeCategory => _activeCategory;
  List<GeneratedPhrase> get history => _history;
  List<GeneratedPhrase> get favorites => _favorites;
  bool get hasSelection => _selectedPictograms.isNotEmpty;
  bool get canSpeak => _generatedText != null && _generatedText!.isNotEmpty;

  List<Pictogram> get currentCategoryPictograms =>
      PictogramData.getByCategory(_activeCategory);

  List<PictogramCategory> get categories => PictogramData.categories;

  BoardProvider({
    required AIService aiService,
    required TTSService ttsService,
  })  : _aiService = aiService,
        _ttsService = ttsService;

  /// Initialize the AI service with an API key.
  void initializeAI(String apiKey) {
    _aiService.initialize(apiKey);
    notifyListeners();
  }

  bool get isAIReady => _aiService.isInitialized;

  // ─── Actions ───

  /// Add a pictogram and start auto-speak timer.
  void addPictogram(Pictogram pictogram) {
    _selectedPictograms = [..._selectedPictograms, pictogram];
    _generatedText = null;
    notifyListeners();

    // Reset the auto-speak timer
    _scheduleAutoSpeak();
  }

  /// Remove the last pictogram and restart the timer.
  void removeLastPictogram() {
    if (_selectedPictograms.isEmpty) return;
    _selectedPictograms = _selectedPictograms.sublist(0, _selectedPictograms.length - 1);
    _generatedText = null;
    notifyListeners();

    // If there are still pictograms, restart the timer
    if (_selectedPictograms.isNotEmpty) {
      _scheduleAutoSpeak();
    } else {
      _cancelAutoSpeak();
    }
  }

  /// Clear all selected pictograms.
  void clearSelection() {
    _cancelAutoSpeak();
    _selectedPictograms = [];
    _generatedText = null;
    _isSpeaking = false;
    notifyListeners();
    _ttsService.stop();
  }

  /// Switch the active pictogram category.
  void setCategory(String categoryId) {
    _activeCategory = categoryId;
    notifyListeners();
  }

  // ─── Auto-speak timer ───

  void _scheduleAutoSpeak() {
    _cancelAutoSpeak();
    _autoSpeakTimer = Timer(autoSpeakDelay, () {
      _autoGenerateAndSpeak();
    });
  }

  void _cancelAutoSpeak() {
    _autoSpeakTimer?.cancel();
    _autoSpeakTimer = null;
  }

  Future<void> _autoGenerateAndSpeak() async {
    if (_selectedPictograms.isEmpty) return;
    if (_isGenerating || _isSpeaking) return;

    await generatePhrase();
    if (_generatedText != null) {
      await speak();
    }
  }

  /// Generate a phrase from the current pictogram sequence using AI.
  Future<void> generatePhrase() async {
    if (_selectedPictograms.isEmpty) return;

    _isGenerating = true;
    _generatedText = null;
    notifyListeners();

    try {
      final text = await _aiService.generatePhrase(_selectedPictograms);
      _generatedText = text;

      // Add to history
      final phrase = GeneratedPhrase(
        id: const Uuid().v4(),
        pictograms: List.from(_selectedPictograms),
        text: text,
        createdAt: DateTime.now(),
      );
      _history.insert(0, phrase);
      if (_history.length > 50) _history = _history.sublist(0, 50);

    } catch (e) {
      _generatedText = _selectedPictograms.map((p) => p.label).join(' ');
    } finally {
      _isGenerating = false;
      notifyListeners();
    }
  }

  /// Generate phrase and immediately speak it (manual trigger).
  Future<void> generateAndSpeak() async {
    _cancelAutoSpeak();
    await generatePhrase();
    if (_generatedText != null) {
      await speak();
    }
  }

  /// Speak the current generated text.
  Future<void> speak() async {
    if (_generatedText == null) return;
    _isSpeaking = true;
    notifyListeners();

    await _ttsService.speak(_generatedText!);

    _isSpeaking = false;
    notifyListeners();
  }

  /// Stop speaking.
  Future<void> stopSpeaking() async {
    await _ttsService.stop();
    _isSpeaking = false;
    notifyListeners();
  }

  /// Repeat the last phrase.
  Future<void> repeatPhrase() async {
    if (_generatedText != null) {
      await speak();
    }
  }

  /// Toggle favorite status of a phrase.
  void toggleFavorite(GeneratedPhrase phrase) {
    final updated = phrase.copyWith(isFavorite: !phrase.isFavorite);

    final historyIndex = _history.indexWhere((p) => p.id == phrase.id);
    if (historyIndex >= 0) {
      _history[historyIndex] = updated;
    }

    if (updated.isFavorite) {
      _favorites.insert(0, updated);
    } else {
      _favorites.removeWhere((p) => p.id == phrase.id);
    }

    notifyListeners();
  }

  /// Load a previously saved phrase into the board.
  void loadPhrase(GeneratedPhrase phrase) {
    _selectedPictograms = List.from(phrase.pictograms);
    _generatedText = phrase.text;
    notifyListeners();
  }

  @override
  void dispose() {
    _cancelAutoSpeak();
    _ttsService.dispose();
    super.dispose();
  }
}

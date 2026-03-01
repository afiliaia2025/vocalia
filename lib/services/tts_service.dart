import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Text-to-Speech service for Vocalia.
/// Speaks generated phrases aloud.
class TTSService {
  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;
  bool _isSpeaking = false;
  
  bool get isSpeaking => _isSpeaking;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Configure for Spanish
      await _tts.setLanguage('es-ES');
      await _tts.setSpeechRate(0.45);  // Slightly slow for clarity
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);

      // For web platform
      if (kIsWeb) {
        await _tts.awaitSpeakCompletion(true);
      }

      _tts.setStartHandler(() {
        _isSpeaking = true;
      });

      _tts.setCompletionHandler(() {
        _isSpeaking = false;
      });

      _tts.setErrorHandler((msg) {
        _isSpeaking = false;
        debugPrint('TTS Error: $msg');
      });

      _isInitialized = true;
    } catch (e) {
      debugPrint('TTS initialization failed: $e');
    }
  }

  /// Speak the given text aloud.
  Future<void> speak(String text) async {
    if (!_isInitialized) await initialize();
    
    if (_isSpeaking) {
      await stop();
    }

    await _tts.speak(text);
  }

  /// Stop any current speech.
  Future<void> stop() async {
    await _tts.stop();
    _isSpeaking = false;
  }

  /// Dispose resources.
  void dispose() {
    _tts.stop();
  }
}

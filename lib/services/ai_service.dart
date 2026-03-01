import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/pictogram.dart';

/// Service that uses Gemini AI to interpret pictogram sequences
/// and generate natural language phrases.
class AIService {
  GenerativeModel? _model;
  final List<String> _conversationHistory = [];

  /// Initialize with API key. In production, this would come from
  /// Firebase Remote Config or environment variables.
  void initialize(String apiKey) {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        maxOutputTokens: 100,
        temperature: 0.3,  // Low temperature for consistent, predictable output
      ),
      systemInstruction: Content.text(_systemPrompt),
    );
  }

  bool get isInitialized => _model != null;

  /// Generate a natural language phrase from a sequence of pictograms.
  Future<String> generatePhrase(List<Pictogram> pictograms) async {
    if (_model == null) {
      return _fallbackPhrase(pictograms);
    }

    try {
      final userMessage = _buildUserPrompt(pictograms);
      final response = await _model!.generateContent([Content.text(userMessage)]);

      final text = response.text?.trim();
      if (text != null && text.isNotEmpty) {
        // Store in conversation history for context
        if (_conversationHistory.length > 10) {
          _conversationHistory.removeAt(0);
        }
        _conversationHistory.add(text);
        return text;
      }

      return _fallbackPhrase(pictograms);
    } catch (e) {
      // Fallback to simple concatenation if AI fails
      return _fallbackPhrase(pictograms);
    }
  }

  /// Build the user prompt from a pictogram sequence.
  String _buildUserPrompt(List<Pictogram> pictograms) {
    final buffer = StringBuffer();
    buffer.writeln('Secuencia de pictogramas seleccionados:');
    for (int i = 0; i < pictograms.length; i++) {
      final p = pictograms[i];
      buffer.writeln('${i + 1}. ${p.emoji} "${p.label}" (categoría: ${p.category}, contexto: ${p.keywords.join(", ")})');
    }

    if (_conversationHistory.isNotEmpty) {
      buffer.writeln('\nContexto: las últimas frases generadas fueron:');
      for (final phrase in _conversationHistory.takeLast(3)) {
        buffer.writeln('- "$phrase"');
      }
    }

    buffer.writeln('\nGenera UNA frase natural en español:');
    return buffer.toString();
  }

  /// Fallback when AI is unavailable — simple label concatenation.
  String _fallbackPhrase(List<Pictogram> pictograms) {
    if (pictograms.isEmpty) return '';
    if (pictograms.length == 1) return pictograms.first.label;
    return pictograms.map((p) => p.label).join(' ');
  }

  /// System prompt that defines AI behavior.
  static const String _systemPrompt = '''
Eres un asistente de comunicación para personas con dificultades del habla.
Recibirás una secuencia de pictogramas (imágenes con etiquetas y contexto).
Tu tarea es interpretar la INTENCIÓN del usuario y generar UNA frase natural en español.

REGLAS ESTRICTAS:
1. Genera SOLO UNA frase corta y natural (máximo 15 palabras)
2. Usa primera persona: "Quiero...", "Me duele...", "Necesito..."
3. Interpreta emociones y contexto (ej: 😢 + 🦷 = "Me duele un diente")
4. Si hay una acción + objeto/lugar, forma una frase con verbo conjugado
5. NUNCA generes contenido inapropiado, violento o sexual
6. NO añadas explicaciones, solo la frase
7. Adapta el tono según el contexto:
   - Con médico/hospital: formal ("Por favor, me duele la cabeza")
   - Con familia/amigos: casual ("Quiero jugar contigo")
   - Emergencia (ayuda): directo ("¡Necesito ayuda ahora!")
8. Si la secuencia es ambigua, elige la interpretación más probable y útil
9. Si hay pictogramas de negación (no) + acción, genera una negación natural
10. Responde SOLO con la frase, sin comillas ni puntuación extra al inicio

EJEMPLOS:
Entrada: 😋 + 🍕 → "Me apetece comer pizza"
Entrada: 😢 + 🦷 → "Me duele un diente"
Entrada: 🚫 + 💤 → "No puedo dormir"
Entrada: 👩 + ❤️ → "Quiero a mamá"
Entrada: 🏠 + 🚗 → "Quiero ir a casa en coche"
Entrada: 🆘 + 🤒 → "¡Necesito ayuda, me encuentro mal!"
Entrada: ⏰ + 🍽️ → "Es hora de comer"
''';
}

/// Extension to get the last N elements from a list.
extension TakeLast<T> on List<T> {
  List<T> takeLast(int n) {
    if (n >= length) return this;
    return sublist(length - n);
  }
}

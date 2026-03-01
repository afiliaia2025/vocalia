import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    // AI Service will be initialized when API key is provided
    // For now, the fallback (label concatenation) works without a key
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

/// Gate that asks for the Gemini API key on first launch.
/// Once provided, navigates to the board.
class _ApiKeyGate extends StatefulWidget {
  const _ApiKeyGate();

  @override
  State<_ApiKeyGate> createState() => _ApiKeyGateState();
}

class _ApiKeyGateState extends State<_ApiKeyGate> {
  final _controller = TextEditingController();
  bool _loading = false;
  bool _skipped = false;

  @override
  Widget build(BuildContext context) {
    if (_skipped) return const BoardScreen();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [VocaliaTheme.primary, VocaliaTheme.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: VocaliaTheme.primary.withAlpha(60),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('🗣️', style: TextStyle(fontSize: 48)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Vocalia',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tu voz, con inteligencia',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // API Key input
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? VocaliaTheme.cardDark : VocaliaTheme.cardLight,
                      borderRadius: BorderRadius.circular(VocaliaTheme.radiusLg),
                      border: Border.all(
                        color: isDark ? Colors.white10 : Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🔑 API Key de Gemini',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Para activar la IA, introduce tu clave de Google AI Studio. '
                          'Puedes obtenerla gratis en aistudio.google.com',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _controller,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'AIzaSy...',
                            filled: true,
                            fillColor: isDark ? VocaliaTheme.bgDark : VocaliaTheme.bgLight,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(VocaliaTheme.radiusSm),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.key_rounded),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _onSubmit,
                            child: _loading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text('Activar IA'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Skip button
                  TextButton(
                    onPressed: () => setState(() => _skipped = true),
                    child: Text(
                      'Continuar sin IA (modo básico)',
                      style: TextStyle(
                        color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
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

    // Initialize AI and navigate to board
    final board = context.read<BoardProvider>();
    // Access AIService through the provider's internal reference
    // For now, we'll initialize it directly
    final aiService = AIService();
    aiService.initialize(key);

    // Replace the board's AI service reference by creating a new provider
    // In production, we'd use a proper DI pattern
    setState(() {
      _loading = false;
      _skipped = true;
    });

    // Re-initialize with the API key
    if (mounted) {
      final boardProvider = context.read<BoardProvider>();
      // The AI service is shared, so we initialize it
      _initializeAI(key);
    }
  }

  void _initializeAI(String key) {
    // Access the AI service from the widget tree
    // For MVP, we use a simple approach
    final board = context.read<BoardProvider>();
    board.initializeAI(key);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/theme.dart';
import '../providers/board_provider.dart';

/// Settings screen for Vocalia.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _apiKeyController = TextEditingController();
  double _speechRate = 0.45;
  double _pictogramSize = 1.0;
  bool _soundFeedback = true;
  bool _showLabels = true;
  String _selectedVoice = 'es-ES';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ─── User Profile ───
          _SectionHeader(title: '👤 Perfil de usuario', subtitle: 'Configuración actual'),
          Builder(
            builder: (context) {
              final board = context.read<BoardProvider>();
              final name = board.userName.isNotEmpty ? board.userName : 'Sin nombre';
              return _SettingsCard(
                isDark: isDark,
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: VocaliaTheme.primary,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Text(
                      'Columnas: ${board.gridColumns} · '
                      'Escala: ${(board.pictogramScale * 100).round()}% · '
                      'Auto-habla: ${board.userProfile.autoSpeakDelayMs}ms',
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.refresh_rounded, color: VocaliaTheme.secondary),
                    title: const Text('Restablecer perfil'),
                    subtitle: const Text('Volver a hacer la configuración inicial'),
                    onTap: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('¿Restablecer perfil?'),
                          content: const Text('Se borrará la configuración actual y volverás a la pantalla de configuración inicial.'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              style: ElevatedButton.styleFrom(backgroundColor: VocaliaTheme.secondary),
                              child: const Text('Restablecer', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true && context.mounted) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('onboarding_complete');
                        await prefs.remove('user_profile');
                        if (context.mounted) {
                          // Force restart the app to show onboarding
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          // Trigger a full app rebuild
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Perfil restablecido. Recarga la app para configurar de nuevo.')),
                          );
                        }
                      }
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // ─── AI Configuration ───
          _SectionHeader(title: '🤖 Inteligencia Artificial', subtitle: 'Configura el motor de IA'),
          _SettingsCard(
            isDark: isDark,
            children: [
              TextField(
                controller: _apiKeyController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'API Key de Gemini',
                  hintText: 'AIzaSy...',
                  prefixIcon: const Icon(Icons.key_rounded),
                  filled: true,
                  fillColor: isDark ? VocaliaTheme.bgDark : VocaliaTheme.bgLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(VocaliaTheme.radiusSm),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.save_rounded),
                    onPressed: () {
                      // TODO: Save API key to SharedPreferences
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('API Key guardada ✓')),
                      );
                    },
                    tooltip: 'Guardar',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Obtén tu clave gratis en aistudio.google.com',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark ? VocaliaTheme.textDarkSecondary : VocaliaTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ─── Voice Settings ───
          _SectionHeader(title: '🔊 Voz', subtitle: 'Ajusta la velocidad y el idioma'),
          _SettingsCard(
            isDark: isDark,
            children: [
              Row(
                children: [
                  const Icon(Icons.speed_rounded, color: VocaliaTheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Velocidad del habla', style: Theme.of(context).textTheme.bodyLarge),
                        Slider(
                          value: _speechRate,
                          min: 0.1,
                          max: 1.0,
                          divisions: 9,
                          label: _speechRate.toStringAsFixed(1),
                          activeColor: VocaliaTheme.primary,
                          onChanged: (val) => setState(() => _speechRate = val),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Lento', style: Theme.of(context).textTheme.bodySmall),
                            Text('Rápido', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              ListTile(
                leading: const Icon(Icons.language_rounded, color: VocaliaTheme.primary),
                title: const Text('Idioma de la voz'),
                trailing: DropdownButton<String>(
                  value: _selectedVoice,
                  items: const [
                    DropdownMenuItem(value: 'es-ES', child: Text('Español (España)')),
                    DropdownMenuItem(value: 'es-MX', child: Text('Español (México)')),
                    DropdownMenuItem(value: 'es-AR', child: Text('Español (Argentina)')),
                    DropdownMenuItem(value: 'en-US', child: Text('English (US)')),
                    DropdownMenuItem(value: 'ca-ES', child: Text('Català')),
                  ],
                  onChanged: (val) => setState(() => _selectedVoice = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ─── Display Settings ───
          _SectionHeader(title: '🎨 Pantalla', subtitle: 'Personaliza la apariencia'),
          _SettingsCard(
            isDark: isDark,
            children: [
              Row(
                children: [
                  const Icon(Icons.zoom_in_rounded, color: VocaliaTheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tamaño de pictogramas', style: Theme.of(context).textTheme.bodyLarge),
                        Slider(
                          value: _pictogramSize,
                          min: 0.7,
                          max: 1.5,
                          divisions: 8,
                          label: '${(_pictogramSize * 100).round()}%',
                          activeColor: VocaliaTheme.primary,
                          onChanged: (val) => setState(() => _pictogramSize = val),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pequeño', style: Theme.of(context).textTheme.bodySmall),
                            Text('Grande', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              SwitchListTile(
                title: const Text('Mostrar etiquetas'),
                subtitle: const Text('Texto debajo de cada pictograma'),
                value: _showLabels,
                activeColor: VocaliaTheme.primary,
                onChanged: (val) => setState(() => _showLabels = val),
              ),
              SwitchListTile(
                title: const Text('Sonido al tocar'),
                subtitle: const Text('Reproduce un sonido al seleccionar'),
                value: _soundFeedback,
                activeColor: VocaliaTheme.primary,
                onChanged: (val) => setState(() => _soundFeedback = val),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ─── About ───
          _SectionHeader(title: 'ℹ️ Acerca de', subtitle: 'Información de la app'),
          _SettingsCard(
            isDark: isDark,
            children: [
              ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [VocaliaTheme.primary, VocaliaTheme.secondary],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text('🗣️', style: TextStyle(fontSize: 24))),
                ),
                title: const Text('Vocalia', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('v1.0.0 (MVP)'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.favorite_rounded, color: Colors.red),
                title: const Text('Hecho con ❤️ para dar voz a quien la necesita'),
                subtitle: const Text('Pictogramas: ARASAAC (CC BY-NC-SA)'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.code_rounded, color: VocaliaTheme.primary),
                title: const Text('Código abierto'),
                subtitle: const Text('github.com/afiliaia2025/vocalia'),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final bool isDark;
  final List<Widget> children;

  const _SettingsCard({required this.isDark, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? VocaliaTheme.cardDark : VocaliaTheme.cardLight,
        borderRadius: BorderRadius.circular(VocaliaTheme.radiusLg),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

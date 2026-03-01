# 🗣️ Vocalia — Tu voz, con inteligencia

App de comunicación aumentativa y alternativa (AAC) para personas con dificultades de comunicación. Usa pictogramas, voz sintetizada e inteligencia artificial para dar voz a quien la necesita.

🌐 **[Probar ahora → vocalia-app.web.app](https://vocalia-app.web.app)**

---

## ✨ Funcionalidades

| Funcionalidad | Descripción |
|---|---|
| 🎨 **200+ pictogramas** | 12 categorías: básico, emociones, acciones, comida, bebidas, lugares, personas, cuerpo, tiempo, objetos, adjetivos, social |
| 🔮 **Predicción inteligente** | Sugiere el siguiente pictograma según contexto (40+ reglas de asociación) |
| 🗣️ **Auto-speak** | Habla automáticamente tras 1.8s de inactividad — sin botón "Hablar" |
| ⚙️ **Onboarding adaptativo** | 4 pasos para configurar la app según capacidad motora, cognitiva y necesidades |
| 🤖 **IA generativa** (opcional) | Genera frases naturales con Gemini a partir de pictogramas seleccionados |
| 📱 **PWA** | Funciona en cualquier dispositivo: web, iOS, Android |

## 🏗️ Tecnología

- **Flutter Web** (Dart)
- **Firebase Hosting** para despliegue
- **Google Gemini** (opcional) para generación de frases
- **SharedPreferences** para persistencia local del perfil

## 📁 Estructura del proyecto

```
vocalia/
├── lib/
│   ├── main.dart                    # Entry point + onboarding flow
│   ├── config/theme.dart            # Design system premium
│   ├── models/
│   │   ├── pictogram.dart           # Modelo de pictograma
│   │   ├── phrase.dart              # Modelo de frase generada
│   │   └── user_profile.dart        # Perfil adaptativo del usuario
│   ├── providers/
│   │   └── board_provider.dart      # Estado central (adaptativo)
│   ├── screens/
│   │   ├── board_screen.dart        # Tablero de comunicación
│   │   ├── onboarding_screen.dart   # Configuración inicial (4 pasos)
│   │   ├── settings_screen.dart     # Ajustes + perfil de usuario
│   │   └── history_screen.dart      # Historial de frases
│   ├── services/
│   │   ├── ai_service.dart          # Integración con Gemini
│   │   ├── tts_service.dart         # Text-to-Speech
│   │   └── prediction_engine.dart   # Motor de predicción contextual
│   └── data/
│       └── pictogram_data.dart      # Base de datos de pictogramas
├── docs/
│   ├── sensor_strategy.md           # Estrategia de innovación (6 conceptos)
│   └── universal_plan.md            # Plan universal (7 perfiles de usuario)
└── firebase.json
```

## 📖 Documentación

- **[Estrategia de Sensores + IA](docs/sensor_strategy.md)** — 6 conceptos innovadores: GazeBoard, MotionSpeak, ContextEngine, FaceState, EdgeLearn, ListenAssist
- **[Plan Universal](docs/universal_plan.md)** — Implementación para 7 perfiles: parálisis cerebral, TEA, Down, ELA, afasia, discapacidad intelectual, degenerativo

## 🚀 Desarrollo local

```bash
flutter pub get
flutter run -d chrome
```

## 📋 Despliegue

```bash
flutter build web --release
npx firebase-tools deploy --only hosting
```

## ❤️ Créditos

- Pictogramas: [ARASAAC](https://arasaac.org) (CC BY-NC-SA)
- IA: Google Gemini
- Hecho con ❤️ para dar voz a quien la necesita

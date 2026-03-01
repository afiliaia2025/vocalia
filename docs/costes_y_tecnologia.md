# Vocalia — Tecnología y Costes por Fase

> Desglose completo de qué herramientas usamos, por qué, y cuánto cuesta cada cosa.

---

## 💰 Resumen Rápido de Costes

| Concepto | Coste |
|---|---|
| **Desarrollo** (Flutter, Dart, todas las fases) | **0€** — yo lo hago |
| **Hosting** (Firebase) | **0€** — tier gratuito |
| **IA generativa** (Gemini) | **0€** con tier gratuito / ~5€/mes si crece |
| **Base de datos** (Firestore) | **0€** — tier gratuito |
| **Almacenamiento** (Firebase Storage) | **0€** — tier gratuito hasta 5GB |
| **Detección facial** (MediaPipe) | **0€** — on-device, gratuito |
| **Sensores** (acelerómetro, GPS, etc.) | **0€** — hardware del teléfono |
| **Wake word** (Picovoice Porcupine) | **0€** — tier gratuito para uso personal |
| **Speech-to-text** (Google ML Kit / Whisper) | **0€** — on-device |
| **Dominio personalizado** (opcional) | ~12€/año |
| | |
| **TOTAL estimado** | **0€ – 5€/mes** |

> [!TIP]
> Vocalia se puede construir ENTERA con tecnologías gratuitas. Los costes solo aparecen si la app escala a miles de usuarios.

---

## Fase 1 — Base Universal

### ¿Qué hacemos?
Tamaño adaptable real, frases rápidas, vocabulario adulto, modo simplificado.

| Funcionalidad | Tecnología | Coste | Explicación |
|---|---|---|---|
| **Tamaño de pictogramas adaptable** | Flutter (`GridView` + `UserProfile`) | 0€ | Solo código — ya tenemos el perfil, falta que la UI lo aplique de verdad |
| **Modo simplificado (4-6 pictogramas)** | Flutter (`GridView` dinámico) | 0€ | Filtramos pictogramas esenciales según perfil |
| **Frases rápidas** | Flutter + `SharedPreferences` | 0€ | Barra de frases frecuentes con un solo toque |
| **Vocabulario adulto** | Datos (nuevo `pictogram_data.dart`) | 0€ | Añadimos categorías: trabajo, transporte, dinero, salud |

> **Coste Fase 1: 0€** — Todo es código Flutter puro.

---

## Fase 2 — Interacción Multimodal

### ¿Qué hacemos?
MotionSpeak, scanning mode, botones zona amplia, GazeBoard (mirada).

| Funcionalidad | Tecnología | Paquete/Librería | Coste | Explicación |
|---|---|---|---|---|
| **MotionSpeak** (inclinación) | Acelerómetro + Giroscopio | [`sensors_plus`](https://pub.dev/packages/sensors_plus) | 0€ | Paquete Flutter gratuito y mantenido por la comunidad. Lee los sensores del teléfono |
| **Scanning mode** | Flutter timer + animaciones | Código propio | 0€ | La app recorre opciones automáticamente, el usuario confirma |
| **Botones zona amplia** | Flutter `GestureDetector` | Código propio | 0€ | Áreas de toque más grandes para manos imprecisas |
| **GazeBoard** (mirada) | Cámara frontal | [`google_mlkit_face_detection`](https://pub.dev/packages/google_mlkit_face_detection) | 0€ | Detección de cara e iris on-device, gratuito. Usa el chip del teléfono |

> **Coste Fase 2: 0€** — Los sensores son hardware que ya tiene el teléfono. Los paquetes son open-source.

---

## Fase 3 — Inteligencia Contextual

### ¿Qué hacemos?
ListenAssist (escucha ambiental), ContextEngine (predicción temporal), rutinas visuales.

| Funcionalidad | Tecnología | Paquete/Servicio | Coste | Explicación |
|---|---|---|---|---|
| **ListenAssist v1** (notas de voz) | Speech-to-text | [`speech_to_text`](https://pub.dev/packages/speech_to_text) | 0€ | Usa el motor de reconocimiento de voz del sistema operativo (Google/Apple). Sin límites |
| **ListenAssist v2** (wake word) | Detección de palabra clave | [Picovoice Porcupine](https://picovoice.ai/porcupine/) | 0€ (personal) | Detecta el nombre del niño ("Marta") sin enviar audio a la nube. Gratuito para uso personal. Comercial: ~5$/mes |
| **ContextEngine v1** (hora + historial) | Reloj + historial local | Flutter nativo + SQLite | 0€ | "Son las 8AM → sugiere desayuno". Todo en local |
| **ContextEngine v2** (GPS + actividad) | GPS + acelerómetro | [`geolocator`](https://pub.dev/packages/geolocator) | 0€ | "Estás en el hospital → sugiere dolor, médico" |
| **Rutinas visuales** (TEA) | Flutter UI + almacenamiento local | `SharedPreferences` / SQLite | 0€ | Agenda visual con pictogramas para estructura diaria |
| **Extracción semántica** (NLU) | Google Gemini API | [Gemini API](https://ai.google.dev) | 0€ (gratis) | Extrae persona, lugar, tiempo de las frases capturadas. **1.500 peticiones gratis/día** |

> [!IMPORTANT]
> **Gemini API tiene tier gratuito muy generoso**: 1,500 peticiones/día, 1M tokens/minuto. Para uso personal, es esencialmente gratis. Si la app escala a miles de usuarios, el coste sería ~5-15€/mes.

> **Coste Fase 3: 0€** para uso personal. Potencialmente ~5€/mes si escala.

---

## Fase 4 — Detección y Bienestar

### ¿Qué hacemos?
FaceState (detección dolor/fatiga), panel del cuidador, alertas.

| Funcionalidad | Tecnología | Paquete/Servicio | Coste | Explicación |
|---|---|---|---|---|
| **FaceState** (detección de dolor/fatiga) | Cámara frontal + ML | [Google ML Kit Face Detection](https://pub.dev/packages/google_mlkit_face_detection) + modelo TFLite propio | 0€ | 468 puntos faciales analizados en el teléfono. Sin enviar fotos a ningún servidor |
| **Modelo de expresiones** | TensorFlow Lite | [`tflite_flutter`](https://pub.dev/packages/tflite_flutter) | 0€ | Modelo ligero (~1.5MB) entrenado con datasets públicos (AffectNet, FER2013) |
| **Panel del cuidador** | Firebase Firestore | [Firebase Firestore](https://firebase.google.com) | 0€ | 50K lecturas/día y 20K escrituras/día gratis. Suficiente para cientos de familias |
| **Alertas** (sin comunicación prolongada) | Firebase Cloud Messaging | [FCM](https://firebase.google.com/products/cloud-messaging) | 0€ | Notificaciones push ilimitadas y gratuitas |

> **Coste Fase 4: 0€** — ML Kit y TFLite son on-device y gratuitos.

---

## Fase 5 — Crecimiento y Comunidad

### ¿Qué hacemos?
Pictogramas personalizados (fotos), multi-idioma, compartir tableros, exportar historial.

| Funcionalidad | Tecnología | Servicio | Coste | Explicación |
|---|---|---|---|---|
| **Pictogramas personalizados** (fotos) | Cámara + Firebase Storage | Firebase Storage | 0€ | 5GB gratis. Una foto = ~200KB. Caben ~25,000 fotos |
| **Compartir tableros** | Firestore + códigos de enlace | Firebase Firestore | 0€ | Un terapeuta crea un tablero → comparte con familias |
| **Multi-idioma** | Flutter `intl` | [`flutter_localizations`](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization) | 0€ | Soporte nativo de Flutter. Español, catalán, inglés, francés |
| **Exportar historial** (PDF) | Generación PDF | [`pdf`](https://pub.dev/packages/pdf) | 0€ | Genera PDF offline: "Las 50 frases más frecuentes de Marta" |
| **PWA nativa** | Service Workers | Ya configurado | 0€ | Funciona offline, se instala como app nativa |

> **Coste Fase 5: 0€** dentro del tier gratuito de Firebase.

---

## 🔥 Firebase — Límites del Tier Gratuito (Spark Plan)

| Servicio | Límite Gratuito | ¿Suficiente? |
|---|---|---|
| **Hosting** | 10 GB transferencia/mes, 1GB almacenamiento | ✅ Sí, para miles de visitas |
| **Firestore** | 1 GiB almacenamiento, 50K lecturas/día, 20K escrituras/día | ✅ Sí, para cientos de familias |
| **Storage** | 5 GB | ✅ Sí, para ~25,000 fotos |
| **Cloud Messaging** (push) | Ilimitado | ✅ Siempre gratis |
| **Authentication** | 10K usuarios/mes | ✅ Sí |

> [!NOTE]
> El plan Spark (gratuito) de Firebase es suficiente durante toda la fase de desarrollo y primeros cientos de usuarios reales. Si la app crece mucho, el plan Blaze (pago por uso) empieza en ~25€/mes para uso moderado.

---

## 🤖 Gemini API — Detalle de Costes

| Modelo | Tier Gratuito | Si escalamos |
|---|---|---|
| **Gemini 2.0 Flash** | 1,500 peticiones/día, 1M tokens/min | $0.10 por 1M tokens input, $0.40 por 1M tokens output |
| **Gemini 2.0 Pro** | 50 peticiones/día | $1.25 por 1M tokens input |

**Uso estimado de Vocalia**: ~50-200 peticiones/día por usuario (generación de frases + extracción semántica).
→ Con el tier gratuito, un usuario puede usar la app sin límite.
→ Con 100 usuarios activos: ~5-15€/mes.

---

## 📊 Tabla Resumen por Fase

| Fase | Tecnologías Principales | Coste Mensual | Tiempo Estimado |
|---|---|---|---|
| **Fase 1** — Base Universal | Flutter puro | **0€** | 1-2 semanas |
| **Fase 2** — Multimodal | sensors_plus, ML Kit | **0€** | 3-4 semanas |
| **Fase 3** — Inteligencia | speech_to_text, Picovoice, Gemini, SQLite | **0€** (personal) | 4-6 semanas |
| **Fase 4** — Bienestar | ML Kit Face, TFLite, Firestore, FCM | **0€** | 4-5 semanas |
| **Fase 5** — Comunidad | Firebase Storage, intl, PDF | **0€** | 3-4 semanas |
| | | | |
| **TOTAL** | | **0 – 5€/mes** | ~15-21 semanas |

---

## ⚡ Resumen Ejecutivo

```
┌─────────────────────────────────────────────────────┐
│                                                      │
│   💻 Desarrollo          → 0€  (yo lo hago)         │
│   ☁️  Infraestructura     → 0€  (Firebase gratuito)  │
│   🤖 IA                  → 0€  (Gemini gratuito)    │
│   📱 Sensores            → 0€  (hardware del móvil) │
│   🧠 Machine Learning    → 0€  (on-device)          │
│   🔊 Voz                 → 0€  (TTS del sistema)    │
│                                                      │
│   TOTAL: 0€/mes para uso personal                    │
│   ~5-25€/mes si escala a 100-1000 usuarios           │
│                                                      │
└─────────────────────────────────────────────────────┘
```

> [!IMPORTANT]
> **¿Cuándo empezaría a costar?** Solo si la app tiene éxito masivo (>1000 usuarios activos diarios). Hasta entonces, TODO es gratuito. Y si llega ese momento, los ingresos de la app cubrirían los costes sobradamente.

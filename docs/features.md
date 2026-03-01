# Vocalia — Especificación Funcional Completa

> Documento de referencia: todas las funciones que debe tener Vocalia, organizadas por módulo, prioridad y tier.

---

## Leyenda

| Símbolo | Significado |
|---|---|
| ✅ | Implementado |
| 🔨 | Por implementar |
| 🔬 | Requiere investigación / experimental |
| **P0** | Crítico — sin esto no hay producto |
| **P1** | Importante — necesario para lanzamiento público |
| **P2** | Valioso — diferenciador competitivo |
| **P3** | Futuro — nice to have |
| 🆓 | Gratuito |
| 💜 | Familiar (14,99€/mes) |
| 🏥 | Profesional (29,99€/mes) |

---

## Módulo 1: Comunicación (el core)

*Lo que hace que una persona pueda "hablar".*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 1.1 | **Tablero de pictogramas** | Cuadrícula visual con pictogramas seleccionables por categoría | 🆓 | P0 | ✅ |
| 1.2 | **Categorías temáticas** | Básico, Emociones, Acciones, Comida, Bebidas, Lugares, Personas, Cuerpo, Tiempo, Objetos, Adjetivos, Social (12 categorías) | 🆓 | P0 | ✅ |
| 1.3 | **Barra de frase** | Muestra los pictogramas seleccionados en orden, como una frase visual | 🆓 | P0 | ✅ |
| 1.4 | **Auto-speak** | La app habla automáticamente tras seleccionar pictogramas (configurable: 1.5–3s) | 🆓 | P0 | ✅ |
| 1.5 | **Hablar manualmente** | Toque en la barra de frase para hablar de inmediato (sin esperar auto-speak) | 🆓 | P0 | ✅ |
| 1.6 | **Borrar / retroceder** | Borrar toda la frase o el último pictograma | 🆓 | P0 | ✅ |
| 1.7 | **Frases rápidas** | Botones de acceso directo: "Tengo hambre", "Me duele", "Quiero ir al baño", "Ayuda" | 🆓 | P1 | 🔨 |
| 1.8 | **Frases rápidas personalizables** | El cuidador puede crear frases rápidas propias | 💜 | P1 | 🔨 |
| 1.9 | **Botón de emergencia** | Botón siempre visible: "AYUDA" / "ME DUELE" con alerta al cuidador | 🆓 | P1 | 🔨 |
| 1.10 | **Teclado de texto libre** | Para usuarios que pueden escribir: escribir → hablar | 💜 | P2 | 🔨 |
| 1.11 | **Vocabulario adulto** | Set de pictogramas para adultos: trabajo, dinero, transporte, salud, relaciones | 🆓 | P1 | 🔨 |
| 1.12 | **Vocabulario por edad** | Filtrar pictogramas según edad configurada (3–5, 6–10, 11–17, 18+) | 🆓 | P1 | 🔨 |

---

## Módulo 2: Predicción e IA

*Lo que hace que la app sea más inteligente que una cuadrícula.*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 2.1 | **Predicción por asociación** | "quiero" → sugiere "comer", "beber", "jugar", "ir" (40+ reglas) | 🆓 | P0 | ✅ |
| 2.2 | **Predicción por frecuencia** | Pictogramas que el usuario más usa aparecen primero | 🆓 | P1 | 🔨 |
| 2.3 | **Predicción temporal** | Sugiere "desayuno" a las 8AM, "cena" a las 20PM | 💜 | P2 | 🔨 |
| 2.4 | **Predicción por ubicación** | En el cole → pictogramas escolares. En casa → pictogramas familiares | 💜 | P2 | 🔨 |
| 2.5 | **Generación de frases con IA** | Pictogramas → frase natural con Gemini ("quiero + agua" → "Tengo sed, ¿me das agua por favor?") | 💜 | P1 | ✅ |
| 2.6 | **EdgeLearn** | Modelo on-device que aprende patrones individuales sin enviar datos a la nube | 💜 | P3 | 🔬 |
| 2.7 | **Sugerencia de respuestas** | Tras escuchar una pregunta, sugiere posibles respuestas | 💜 | P2 | 🔨 |

---

## Módulo 3: Interacción por Sensores

*Lo que permite usar la app sin tocar la pantalla.*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 3.1 | **Toque estándar** | Interacción clásica por toque | 🆓 | P0 | ✅ |
| 3.2 | **Botones de zona amplia** | Área de toque expandida para usuarios con toque impreciso (50% más grande) | 🆓 | P1 | 🔨 |
| 3.3 | **MotionSpeak — Confirmar por inclinación** | Inclinar derecha = SÍ, inclinar izquierda = NO, sacudir = borrar | 🆓 | P2 | 🔨 |
| 3.4 | **Scanning mode (barrido)** | La app recorre las opciones una por una; un toque (o pulsador) selecciona | 🆓 | P1 | 🔨 |
| 3.5 | **Switch access** | Compatible con pulsadores externos Bluetooth | 🆓 | P2 | 🔨 |
| 3.6 | **GazeBoard — Selección por mirada** | Cámara frontal + MediaPipe + modelo de regresión de mirada | 💜 | P2 | 🔬 |
| 3.7 | **Calibración de mirada** | Proceso guiado de calibración (mirar 9 puntos en pantalla) | 💜 | P2 | 🔬 |
| 3.8 | **Detección de intención pre-toque** | Detecta micro-movimientos antes del toque para anticipar selección | 💜 | P3 | 🔬 |
| 3.9 | **Vibración como feedback** | Vibración háptica al seleccionar pictograma, confirmar frase, error | 🆓 | P1 | 🔨 |

---

## Módulo 4: ListenAssist (Escucha Ambiental)

*Lo que ninguna otra app AAC tiene.*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 4.1 | **Wake word** | Detecta el nombre del usuario ("Marta") como activador | 💜 | P2 | 🔨 |
| 4.2 | **Captura de contexto** | "Marta, mañana vamos a casa de Lucía" → guarda evento | 💜 | P2 | 🔨 |
| 4.3 | **Álbum de contextos** | Línea temporal visual de eventos capturados | 💜 | P2 | 🔨 |
| 4.4 | **Sugerencias por contexto** | Al día siguiente, pictogramas de "Lucía", "ir", "casa" aparecen primero | 💜 | P2 | 🔨 |
| 4.5 | **Notas de voz del cuidador** | El padre habla a la app: "Hoy hemos estado en el parque y Marta ha jugado con un perro" | 💜 | P1 | 🔨 |
| 4.6 | **Modo "Cuéntame"** | Genera una narración con pictogramas de lo que hizo hoy, basada en contextos capturados | 💜 | P3 | 🔬 |
| 4.7 | **Procesamiento 100% on-device** | Todo el audio se procesa localmente, nunca se envía a la nube | 💜 | P0 | 🔨 |

---

## Módulo 5: Perfil de Usuario y Onboarding

*Lo que adapta la app a cada persona.*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 5.1 | **Onboarding de 4 pasos** | Nombre/edad, capacidad motora, nivel cognitivo, necesidades comunicativas | 🆓 | P0 | ✅ |
| 5.2 | **Auto-configuración de UI** | Columnas, tamaño de pictogramas, delay de auto-speak, según perfil | 🆓 | P0 | ✅ |
| 5.3 | **Restablecer perfil** | Botón en ajustes para volver al onboarding | 🆓 | P0 | ✅ |
| 5.4 | **Multi-perfil** | Varios usuarios en un mismo dispositivo (ella en colegio, él en casa) | 💜 | P2 | 🔨 |
| 5.5 | **Perfil en la nube** | Sincronizar perfil entre dispositivos del usuario | 💜 | P2 | 🔨 |
| 5.6 | **Importar/exportar perfil** | Compartir configuración por enlace o QR | 🏥 | P2 | 🔨 |

---

## Módulo 6: Herramientas del Cuidador

*Lo que necesita quien cuida, educa o trata al usuario.*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 6.1 | **Historial de frases** | Todo lo que el usuario ha comunicado, con hora y fecha | 🆓 | P0 | ✅ |
| 6.2 | **Favoritos** | Marcar frases como favoritas para reutilizar | 🆓 | P1 | ✅ |
| 6.3 | **Panel del cuidador** | Dashboard: frases/día, categorías más usadas, horarios de uso, alertas | 💜 | P2 | 🔨 |
| 6.4 | **Exportar informe PDF** | "Las 50 frases más frecuentes de Marta este mes" para el terapeuta | 🏥 | P2 | 🔨 |
| 6.5 | **Alerta de silencio** | Notificación si el usuario lleva X horas sin comunicar | 💜 | P2 | 🔨 |
| 6.6 | **Modo terapeuta** | Gestionar tableros de múltiples pacientes desde una cuenta | 🏥 | P2 | 🔨 |
| 6.7 | **Tableros compartidos** | Un terapeuta crea tablero personalizado y lo comparte con la familia | 🏥 | P2 | 🔨 |
| 6.8 | **Estadísticas de progreso** | Gráficas de evolución: vocabulario activo, frases/día, diversidad | 🏥 | P2 | 🔨 |
| 6.9 | **Acceso protegido por PIN** | El cuidador protege ajustes y panel para que el usuario no los modifique | 🆓 | P1 | 🔨 |

---

## Módulo 7: Detección y Bienestar

*Lo que protege al usuario.*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 7.1 | **FaceState — Detección de dolor** | Cámara frontal detecta ceño fruncido → sugiere "¿Te duele?" | 💜 | P3 | 🔬 |
| 7.2 | **Detección de fatiga** | Ojos entrecerrados, bostezos → simplifica la UI automáticamente | 💜 | P3 | 🔬 |
| 7.3 | **Adaptación por fatiga** | Si el usuario tarda mucho en seleccionar, reduce opciones a 4–6 | 🆓 | P2 | 🔨 |
| 7.4 | **Escala de dolor visual** | Escala de 1–5 con caras de dolor para comunicar intensidad | 🆓 | P1 | 🔨 |
| 7.5 | **Mapa corporal** | Silueta del cuerpo donde señalar "dónde duele" | 🆓 | P1 | 🔨 |

---

## Módulo 8: Accesibilidad y UX

*Lo que hace que la app sea usable para TODOS.*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 8.1 | **Tamaño adaptable** | Pictogramas de 1.0× a 2.0× según perfil | 🆓 | P0 | ✅ |
| 8.2 | **Alto contraste** | Modo de alto contraste para baja visión | 🆓 | P1 | 🔨 |
| 8.3 | **Modo oscuro** | Tema dark automático o manual | 🆓 | P1 | ✅ |
| 8.4 | **Feedback sonoro** | Sonido al seleccionar pictograma (configurable) | 🆓 | P1 | 🔨 |
| 8.5 | **Pictogramas personalizados** | Fotos propias como pictograma (el gato, la abuela, el cole) | 💜 | P1 | 🔨 |
| 8.6 | **Colores por categoría** | Cada categoría tiene su color (básico=dorado, emociones=rosa, etc.) | 🆓 | P0 | ✅ |
| 8.7 | **Rutinas visuales** | Agenda diaria con pictogramas (para TEA: estructura = tranquilidad) | 💜 | P2 | 🔨 |
| 8.8 | **Modo simplificado** | Solo 4–6 pictogramas en pantalla (para discapacidad intelectual severa) | 🆓 | P1 | 🔨 |
| 8.9 | **Animaciones suaves** | Transiciones premium pero sin marear al usuario | 🆓 | P0 | ✅ |

---

## Módulo 9: Voz y Habla

*Cómo suena Vocalia.*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 9.1 | **TTS (Text-to-Speech)** | Síntesis de voz nativa del dispositivo | 🆓 | P0 | ✅ |
| 9.2 | **Velocidad de habla configurable** | Slider lento ↔ rápido | 🆓 | P0 | ✅ |
| 9.3 | **Selección de idioma** | es-ES, es-MX, en-US, ca-ES, etc. | 🆓 | P0 | ✅ |
| 9.4 | **Voz infantil** | Opción de voz con tono de niño (si el usuario es niño) | 💜 | P2 | 🔨 |
| 9.5 | **Voz personalizada** | Clonar la voz del usuario a partir de grabaciones previas | 💜 | P3 | 🔬 |
| 9.6 | **Pronunciar cada pictograma al seleccionar** | Feedback inmediato: toco "agua" → oigo "agua" | 🆓 | P1 | 🔨 |

---

## Módulo 10: Plataforma e Integración

*Dónde y cómo funciona Vocalia.*

| # | Función | Descripción | Tier | Prioridad | Estado |
|---|---|---|---|---|---|
| 10.1 | **PWA (web)** | Funciona en cualquier navegador sin instalar | 🆓 | P0 | ✅ |
| 10.2 | **Offline mode** | Funciona sin internet (excepto IA generativa) | 🆓 | P1 | 🔨 |
| 10.3 | **Android nativo** | App en Google Play | 🆓 | P1 | 🔨 |
| 10.4 | **iOS nativo** | App en App Store | 🆓 | P2 | 🔨 |
| 10.5 | **Multi-idioma UI** | Interfaz en español, catalán, euskera, inglés, francés | 🆓 | P2 | 🔨 |
| 10.6 | **GDPR compliance** | Toda la privacidad local, consentimiento explícito | 🆓 | P1 | 🔨 |
| 10.7 | **Firebase backend** | Auth, Firestore (cloud sync), Hosting, Analytics | 💜 | P1 | ✅ (parcial) |

---

## Resumen por Tier

### 🆓 Plan Gratuito (gratis para siempre)
> Tablero completo, 200+ pictogramas, auto-speak, predicción por asociación, onboarding adaptativo, historial, favoritos, scanning mode, botón de emergencia, escala de dolor, mapa corporal, modo simplificado, modo oscuro, alto contraste

### 💜 Plan Familiar (14,99€/mes)
> Todo lo gratuito + ListenAssist, predicción temporal/ubicación, IA generativa, pictogramas personalizados, rutinas, panel del cuidador, alertas, multi-perfil, GazeBoard, voz infantil, adaptación por fatiga

### 🏥 Plan Profesional (29,99€/mes)
> Todo lo Familiar + multi-paciente, informes PDF, tableros compartidos, estadísticas de progreso, importar/exportar perfil

---

## Conteo de funciones

| | Total | Implementadas | Pendientes | Experimentales |
|---|---|---|---|---|
| **Módulo 1** — Comunicación | 12 | 6 | 6 | 0 |
| **Módulo 2** — Predicción & IA | 7 | 2 | 4 | 1 |
| **Módulo 3** — Sensores | 9 | 1 | 5 | 3 |
| **Módulo 4** — ListenAssist | 7 | 0 | 5 | 2 |
| **Módulo 5** — Perfil | 6 | 3 | 3 | 0 |
| **Módulo 6** — Cuidador | 9 | 2 | 7 | 0 |
| **Módulo 7** — Bienestar | 5 | 0 | 3 | 2 |
| **Módulo 8** — Accesibilidad | 9 | 5 | 4 | 0 |
| **Módulo 9** — Voz | 6 | 3 | 2 | 1 |
| **Módulo 10** — Plataforma | 7 | 2 | 5 | 0 |
| **TOTAL** | **77** | **24 (31%)** | **44 (57%)** | **9 (12%)** |

# Vocalia — Plan de Negocio

> App de comunicación aumentativa con IA para personas con dificultades de comunicación

---

## 1. Resumen Ejecutivo

**Vocalia** es una app de comunicación aumentativa y alternativa (AAC) que usa inteligencia artificial y los sensores estándar del smartphone para dar voz a personas que no pueden comunicarse verbalmente.

**El problema**: Las apps AAC actuales cuestan 299€, solo funcionan en iPad, y asumen que el usuario puede tocar la pantalla con precisión. El 90% de las personas que necesitan AAC no tienen acceso a ninguna herramienta.

**La solución**: Vocalia es **gratuita**, funciona en **cualquier dispositivo** (web, iOS, Android), se **auto-configura** según las capacidades del usuario, y usa **IA** para predecir lo que quiere decir.

**Estado actual**: MVP funcional desplegado en [vocalia-app.web.app](https://vocalia-app.web.app) con 200+ pictogramas, predicción inteligente, auto-speak y onboarding adaptativo.

---

## 2. El Problema

### 2.1 Datos globales
- **70 millones** de personas en el mundo necesitan AAC
- Solo el **10%** tiene acceso a alguna herramienta
- En **España**: ~120.000 usuarios potenciales directos
- En **Navarra**: ~3.500 personas con discapacidad que afecta la comunicación

### 2.2 Las barreras actuales

| Barrera | Impacto |
|---|---|
| **Precio** (299€ por app + iPad obligatorio) | Excluye a familias con pocos recursos |
| **Solo iPad** | 80% del mercado móvil es Android |
| **Configuración compleja** | Requiere logopeda para configurar |
| **Toque preciso obligatorio** | Excluye a usuarios con parálisis cerebral, ELA, Parkinson |
| **Sin inteligencia** | Cuadrículas estáticas que no aprenden ni predicen |

### 2.3 El coste de no comunicarse

Un niño que no puede expresar dolor, hambre, o emociones sufre:
- Mayor riesgo de **depresión y aislamiento** social
- **Frustración** que se manifiesta como conducta disruptiva
- Peor **evolución clínica** (el médico no sabe qué le duele)
- La familia sufre **estrés crónico** y culpa

---

## 3. La Solución: Vocalia

### 3.1 Qué hace Vocalia (hoy — MVP)

| Funcionalidad | Descripción |
|---|---|
| 🎨 200+ pictogramas | 12 categorías, basados en ARASAAC |
| 🔮 Predicción inteligente | 40+ reglas de asociación contextuales |
| 🗣️ Auto-speak | Habla automáticamente tras seleccionar pictogramas |
| ⚙️ Onboarding adaptativo | 4 pasos para configurar según capacidad motora/cognitiva |
| 🤖 IA generativa | Genera frases naturales con Gemini (opcional) |
| 📱 PWA | Funciona en web, iOS y Android sin instalar |

### 3.2 Qué hará Vocalia (innovaciones planificadas)

| Concepto | Tecnología | Impacto |
|---|---|---|
| **GazeBoard** | Cámara frontal + MediaPipe | Selección por mirada sin hardware de 5.000€ |
| **MotionSpeak** | Acelerómetro + giroscopio | Confirmar/cancelar inclinando el móvil |
| **ListenAssist** | Micrófono + NLP on-device | Captura contexto ("Marta, mañana vamos al parque") |
| **ContextEngine** | Hora + GPS + calendario | Sugiere pictogramas según momento del día |
| **FaceState** | Cámara frontal + ML | Detecta dolor, fatiga, frustración |
| **EdgeLearn** | TFLite on-device | Aprende patrones del usuario sin enviar datos |

---

## 4. Mercado

### 4.1 Tamaño del mercado global AAC

| Métrica | Valor |
|---|---|
| Mercado global AAC 2024 | **$2.09B** |
| Proyección 2025 | **$2.34B** |
| CAGR 2024–2031 | **10–11.9%** |
| Proyección 2028 | **$3.25B** |

*Fuentes: Research and Markets, Verified Market Research, The Business Research Company*

### 4.2 Mercado objetivo España

| Segmento | Usuarios estimados | Gasto actual |
|---|---|---|
| Parálisis cerebral | ~33.000 | 299€ (si iPad) o 0€ (sin acceso) |
| TEA (no verbal / limitado) | ~30.000 | Variable |
| Ictus con afasia | ~25.000/año nuevos | Poca oferta adecuada |
| ELA | ~4.000 | Hardware 5.000€+ |
| Síndrome de Down | ~15.000 | Apps básicas gratuitas |
| Discapacidad intelectual | ~15.000 | Poco cubierto |
| **Total España** | **~120.000** | |
| **Navarra** | **~3.500** | |

### 4.3 Usuarios pagadores potenciales

Asumiendo:
- **60%** usan plan gratuito
- **30%** plan Familiar (39€/año)
- **10%** plan Profesional (99€/año)

Con solo **5.000 usuarios** en España:
- 1.500 × 39€ = **58.500€/año**
- 500 × 99€ = **49.500€/año**
- **Total: ~108.000€/año** solo en España

Con expansión a Latinoamérica (400M hispanohablantes):
- Potencial de **20.000+ usuarios pagadores** = **500.000€+/año**

---

## 5. Modelo de Negocio

### 5.1 Freemium ético

| Tier | Precio | Incluye |
|---|---|---|
| **Gratuito** | 0€ | Tablero completo, 200+ pictogramas, auto-speak, predicción básica |
| **Familiar** | 4.99€/mes o 39€/año | ListenAssist, pictogramas personalizados (fotos), multi-perfil, ContextEngine |
| **Profesional** | 9.99€/mes o 99€/año | Multi-paciente, exportar informes, compartir tableros, dashboard de progreso |
| **Institucional** | Contacto | Licencia para centros educativos, hospitales, centros de rehabilitación |

> **Principio ético**: el plan gratuito debe ser **genuinamente útil**. Nadie debe quedarse sin comunicarse por no poder pagar.

### 5.2 Otras vías de ingresos

| Vía | Potencial |
|---|---|
| **Subvenciones y becas** | Programa Innova, convocatorias europeas (Horizon Europe), ONCE, COCEMFE |
| **Licencias institucionales** | Gobiernos autonómicos para centros de educación especial |
| **Proyectos de investigación** | Colaboraciones con universidades (UPNA, UNAV) |
| **Marca blanca** | Adapter Vocalia para hospitales o residencias con su branding |

---

## 6. Estrategia de Financiación

### 6.1 Programa Innova 2025 — Fundación Caja Navarra

| Aspecto | Detalle |
|---|---|
| **Convocante** | Fundación Caja Navarra + Fundación "la Caixa" |
| **Dotación total** | 3.000.000€ (57 proyectos seleccionados de 275) |
| **Ámbito social** | 18 proyectos sociales seleccionados |
| **Encaje de Vocalia** | ✅ Personas con discapacidad |
| | ✅ Inclusión digital como herramienta de inclusión social |
| | ✅ Mejora de calidad de vida |
| | ✅ Innovación tecnológica con impacto social |
| **Requisito** | Entidad sin ánimo de lucro con sede en Navarra |

> [!IMPORTANT]
> **Acción necesaria**: Para presentar al Programa Innova, necesitamos constituir una **asociación o fundación sin ánimo de lucro** en Navarra. Esto es compatible con tener también una empresa (SL) para la parte comercial.

### 6.2 Estructura legal propuesta

```
┌─────────────────────────────────────┐
│  Asociación Vocalia (sin ánimo)     │ ← Recibe subvenciones
│  - Programa Innova                  │    (Innova, ONCE, etc.)
│  - Investigación con UPNA           │
│  - Plan gratuito para todos         │
└──────────────┬──────────────────────┘
               │ licencia de uso
┌──────────────▼──────────────────────┐
│  Vocalia Comunicación SL            │ ← Ingresos comerciales
│  - Planes Familiar/Profesional      │    (premium, institucional)
│  - Licencias institucionales        │
│  - Expansión internacional          │
└─────────────────────────────────────┘
```

### 6.3 Hoja de ruta de financiación

| Fase | Cuándo | Fuente | Cantidad estimada |
|---|---|---|---|
| **Semilla** | 2026 Q2 | Programa Innova FCN | 30.000–50.000€ |
| **Validación** | 2026 Q3 | ONCE, COCEMFE, premios accesibilidad | 10.000–30.000€ |
| **Crecimiento** | 2027 | Horizon Europe / Next Digital Innovation Hubs | 50.000–150.000€ |
| **Escala** | 2027+ | Ingresos propios + inversión de impacto | Autosostenible |

---

## 7. Competencia

| | **Proloquo2Go** | **TouchChat** | **TD Snap** | **Vocalia** |
|---|---|---|---|---|
| Precio | 299€ | 299€ | 299€ + hardware | **Gratis** + premium |
| Plataforma | Solo iPad | Solo iPad | iPad + Tobii | **Web + iOS + Android** |
| IA predictiva | ❌ | ❌ | Básica | ✅ **Contextual + temporal** |
| Eye tracking | ❌ (necesita Tobii 5.000€) | ❌ | Solo con hardware | ✅ **Con cámara del móvil** |
| Escucha ambiental | ❌ | ❌ | ❌ | ✅ **ListenAssist** |
| Auto-configuración | ❌ Manual | ❌ Manual | ❌ Manual | ✅ **Onboarding adaptativo** |
| Privacidad | Cloud | Cloud | Cloud | ✅ **Todo on-device** |

**Ventaja competitiva sostenible**: La combinación de IA + sensores + gratuidad + cross-platform no la ofrece nadie. Y la barrera técnica (ML on-device, procesamiento de señales biométricas) es difícil de replicar.

---

## 8. Proyecciones Financieras (3 años)

### 8.1 Gastos

| Concepto | Año 1 | Año 2 | Año 3 |
|---|---|---|---|
| Desarrollo (1 dev + diseñador part-time) | 40.000€ | 50.000€ | 60.000€ |
| Infraestructura (Firebase, dominio, certificados) | 1.200€ | 2.500€ | 5.000€ |
| Marketing y divulgación | 3.000€ | 8.000€ | 15.000€ |
| Validación clínica (terapeutas, trials) | 5.000€ | 10.000€ | 5.000€ |
| Legal (asociación + SL + GDPR) | 3.000€ | 1.000€ | 1.000€ |
| **Total gastos** | **52.200€** | **71.500€** | **86.000€** |

### 8.2 Ingresos

| Concepto | Año 1 | Año 2 | Año 3 |
|---|---|---|---|
| Subvenciones (Innova + otras) | 40.000€ | 50.000€ | 30.000€ |
| Plan Familiar (usuarios pagadores) | 2.000€ | 25.000€ | 80.000€ |
| Plan Profesional | 0€ | 10.000€ | 40.000€ |
| Institucional | 0€ | 5.000€ | 30.000€ |
| **Total ingresos** | **42.000€** | **90.000€** | **180.000€** |

### 8.3 Usuarios proyectados

| Métrica | Año 1 | Año 2 | Año 3 |
|---|---|---|---|
| Usuarios totales | 500 | 3.000 | 10.000 |
| Usuarios pagadores | 50 | 600 | 2.500 |
| Tasa de conversión | 10% | 20% | 25% |

---

## 9. Equipo Necesario

| Rol | Dedicación | Notas |
|---|---|---|
| **Desarrollador principal** | Full-time | Flutter + ML + Firebase |
| **Logopeda / experto en AAC** | Part-time | Validación del vocabulario y flujo comunicativo |
| **Diseñador UX accesible** | Part-time | Especializado en diversidad funcional |
| **Terapeuta ocupacional** | Consultor | Validación de inputs alternativos (mirada, inclinación) |
| **Asesor médico** | Consultor | Para publicaciones y credibilidad clínica |

> **Realidad**: en Año 1, tú + yo (IA) cubrimos desarrollo y diseño. El logopeda y el terapeuta pueden ser colaboraciones pro-bono con la UPNA o centros de Navarra.

---

## 10. Riesgos y Mitigación

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| No conseguir Programa Innova | Media | Alto | Tener solicitudes paralelas en ONCE, premios Vodafone, CEIN |
| Eye tracking impreciso en móvil | Media | Medio | Lanzar como "beta experimental" + comunicar limitaciones honestamente |
| Poca adopción (inercia de terapeutas) | Alta | Alto | Buscar 5 "terapeutas campeones" que validen y divulguen |
| Competidor grande copia el modelo | Baja | Medio | Ventaja de speed + comunidad + enfoque ético |
| Regulación médica (CE marking) | Baja | Alto | Posicionar como "herramienta educativa", no "dispositivo médico" |

---

## 11. Roadmap de Implementación

| Fase | Periodo | Hito |
|---|---|---|
| **MVP** ✅ | Completado | App funcional con 200+ pictogramas, predicción, auto-speak, onboarding |
| **Validación** | 2026 Abr–Jun | 5 familias piloto en Navarra, feedback de 2 logopedas |
| **Innova** | 2026 May | Presentar al Programa Innova de Fundación Caja Navarra |
| **Beta pública** | 2026 Jul | Lanzamiento abierto con plan gratuito |
| **Sensores v1** | 2026 Sep | MotionSpeak + ContextEngine |
| **Premium** | 2026 Oct | Lanzamiento planes Familiar y Profesional |
| **ListenAssist** | 2027 Q1 | Escucha ambiental + memoria contextual |
| **GazeBoard** | 2027 Q2 | Eye tracking con cámara del móvil |
| **Expansión** | 2027 Q3 | Latinoamérica (español) + multiidioma |

---

## 12. Impacto Social Medible

Para la solicitud a Innova, estos son los KPIs de impacto:

| Indicador | Meta Año 1 | Meta Año 2 |
|---|---|---|
| Familias navarras usando Vocalia | 50 | 200 |
| Frases comunicadas por día (media por usuario) | 15 | 30 |
| Reducción en coste de AAC por familia | 299€ → 0€ | 299€ → 0€ |
| Terapeutas colaboradores en Navarra | 5 | 15 |
| Publicaciones / ponencias | 1 | 3 |

---

## 13. Próximos Pasos Inmediatos

- [ ] Constituir asociación sin ánimo de lucro en Navarra
- [ ] Contactar con la Fundación Caja Navarra (vía cuñado) para confirmar plazos de Programa Innova 2026
- [ ] Realizar 5 pruebas piloto con familias navarras
- [ ] Contactar departamento de logopedia de la UPNA para colaboración
- [ ] Preparar video demo de 2 minutos para la solicitud

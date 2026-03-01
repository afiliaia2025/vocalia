import '../models/pictogram.dart';

/// Provides the built-in pictogram library organized by categories.
/// Comprehensive library for full AAC communication.
class PictogramData {

  static const List<PictogramCategory> categories = [
    PictogramCategory(id: 'basic', name: 'Básico', emoji: '⭐', sortOrder: 0),
    PictogramCategory(id: 'emotions', name: 'Emociones', emoji: '😊', sortOrder: 1),
    PictogramCategory(id: 'actions', name: 'Acciones', emoji: '✋', sortOrder: 2),
    PictogramCategory(id: 'food', name: 'Comida', emoji: '🍕', sortOrder: 3),
    PictogramCategory(id: 'drinks', name: 'Bebidas', emoji: '💧', sortOrder: 4),
    PictogramCategory(id: 'places', name: 'Lugares', emoji: '🏠', sortOrder: 5),
    PictogramCategory(id: 'people', name: 'Personas', emoji: '👨‍👩‍👧', sortOrder: 6),
    PictogramCategory(id: 'body', name: 'Cuerpo', emoji: '🦷', sortOrder: 7),
    PictogramCategory(id: 'time', name: 'Tiempo', emoji: '🕐', sortOrder: 8),
    PictogramCategory(id: 'objects', name: 'Objetos', emoji: '📱', sortOrder: 9),
    PictogramCategory(id: 'adjectives', name: 'Adjetivos', emoji: '🎨', sortOrder: 10),
    PictogramCategory(id: 'social', name: 'Social', emoji: '💬', sortOrder: 11),
  ];

  static const List<Pictogram> allPictograms = [

    // ═══════════════════════════════════════
    // ⭐ BÁSICO — Core communication essentials
    // ═══════════════════════════════════════
    Pictogram(id: 'basic_yes', label: 'sí', emoji: '✅', category: 'basic', keywords: ['afirmar', 'aceptar', 'vale', 'correcto'], sortOrder: 0),
    Pictogram(id: 'basic_no', label: 'no', emoji: '❌', category: 'basic', keywords: ['negar', 'rechazar', 'no quiero'], sortOrder: 1),
    Pictogram(id: 'basic_want', label: 'quiero', emoji: '👉', category: 'basic', keywords: ['deseo', 'pedir', 'necesito'], sortOrder: 2),
    Pictogram(id: 'basic_no_want', label: 'no quiero', emoji: '🙅', category: 'basic', keywords: ['rechazo', 'negar'], sortOrder: 3),
    Pictogram(id: 'basic_more', label: 'más', emoji: '➕', category: 'basic', keywords: ['otro', 'repetir', 'adicional'], sortOrder: 4),
    Pictogram(id: 'basic_done', label: 'terminé', emoji: '🏁', category: 'basic', keywords: ['acabar', 'listo', 'fin', 'basta'], sortOrder: 5),
    Pictogram(id: 'basic_help', label: 'ayuda', emoji: '🆘', category: 'basic', keywords: ['socorro', 'necesitar', 'urgente'], sortOrder: 6),
    Pictogram(id: 'basic_please', label: 'por favor', emoji: '🙏', category: 'basic', keywords: ['pedir', 'amable', 'educado'], sortOrder: 7),
    Pictogram(id: 'basic_thanks', label: 'gracias', emoji: '💝', category: 'basic', keywords: ['agradecer', 'amable'], sortOrder: 8),
    Pictogram(id: 'basic_sorry', label: 'perdón', emoji: '😔', category: 'basic', keywords: ['disculpa', 'lo siento'], sortOrder: 9),
    Pictogram(id: 'basic_wait', label: 'espera', emoji: '⏸️', category: 'basic', keywords: ['parar', 'momento', 'calma'], sortOrder: 10),
    Pictogram(id: 'basic_where', label: 'dónde', emoji: '❓', category: 'basic', keywords: ['lugar', 'preguntar', 'buscar'], sortOrder: 11),
    Pictogram(id: 'basic_who', label: 'quién', emoji: '🤷', category: 'basic', keywords: ['persona', 'preguntar'], sortOrder: 12),
    Pictogram(id: 'basic_what', label: 'qué', emoji: '❔', category: 'basic', keywords: ['preguntar', 'cosa'], sortOrder: 13),
    Pictogram(id: 'basic_when', label: 'cuándo', emoji: '🕰️', category: 'basic', keywords: ['tiempo', 'preguntar'], sortOrder: 14),
    Pictogram(id: 'basic_me', label: 'yo', emoji: '🙋', category: 'basic', keywords: ['mi', 'propio', 'mío'], sortOrder: 15),
    Pictogram(id: 'basic_you', label: 'tú', emoji: '🫵', category: 'basic', keywords: ['tu', 'tuyo'], sortOrder: 16),
    Pictogram(id: 'basic_this', label: 'esto', emoji: '👆', category: 'basic', keywords: ['ese', 'eso', 'aquí'], sortOrder: 17),

    // ═══════════════════════════════════════
    // 😊 EMOCIONES
    // ═══════════════════════════════════════
    Pictogram(id: 'emo_happy', label: 'feliz', emoji: '😊', category: 'emotions', keywords: ['contento', 'alegre', 'bien'], sortOrder: 0),
    Pictogram(id: 'emo_sad', label: 'triste', emoji: '😢', category: 'emotions', keywords: ['llorar', 'pena', 'mal'], sortOrder: 1),
    Pictogram(id: 'emo_angry', label: 'enfadado', emoji: '😡', category: 'emotions', keywords: ['rabia', 'molesto', 'furioso'], sortOrder: 2),
    Pictogram(id: 'emo_scared', label: 'asustado', emoji: '😨', category: 'emotions', keywords: ['miedo', 'terror', 'susto'], sortOrder: 3),
    Pictogram(id: 'emo_tired', label: 'cansado', emoji: '😴', category: 'emotions', keywords: ['sueño', 'dormir', 'agotado'], sortOrder: 4),
    Pictogram(id: 'emo_sick', label: 'enfermo', emoji: '🤒', category: 'emotions', keywords: ['malo', 'fiebre', 'dolor'], sortOrder: 5),
    Pictogram(id: 'emo_love', label: 'amor', emoji: '❤️', category: 'emotions', keywords: ['querer', 'cariño', 'gustar'], sortOrder: 6),
    Pictogram(id: 'emo_surprised', label: 'sorprendido', emoji: '😲', category: 'emotions', keywords: ['asombro', 'wow'], sortOrder: 7),
    Pictogram(id: 'emo_hungry', label: 'hambre', emoji: '😋', category: 'emotions', keywords: ['comer', 'apetito'], sortOrder: 8),
    Pictogram(id: 'emo_thirsty', label: 'sed', emoji: '🥵', category: 'emotions', keywords: ['beber', 'agua'], sortOrder: 9),
    Pictogram(id: 'emo_bored', label: 'aburrido', emoji: '😑', category: 'emotions', keywords: ['nada', 'rollo'], sortOrder: 10),
    Pictogram(id: 'emo_pain', label: 'dolor', emoji: '😣', category: 'emotions', keywords: ['duele', 'daño', 'mal'], sortOrder: 11),
    Pictogram(id: 'emo_nervous', label: 'nervioso', emoji: '😬', category: 'emotions', keywords: ['ansioso', 'preocupado'], sortOrder: 12),
    Pictogram(id: 'emo_calm', label: 'tranquilo', emoji: '😌', category: 'emotions', keywords: ['relajado', 'paz', 'bien'], sortOrder: 13),
    Pictogram(id: 'emo_proud', label: 'orgulloso', emoji: '😎', category: 'emotions', keywords: ['genial', 'bien hecho'], sortOrder: 14),
    Pictogram(id: 'emo_confused', label: 'confundido', emoji: '😕', category: 'emotions', keywords: ['no entiendo', 'perdido'], sortOrder: 15),
    Pictogram(id: 'emo_excited', label: 'emocionado', emoji: '🤩', category: 'emotions', keywords: ['ilusión', 'contento'], sortOrder: 16),
    Pictogram(id: 'emo_shy', label: 'vergüenza', emoji: '🫣', category: 'emotions', keywords: ['tímido', 'ruborizado'], sortOrder: 17),

    // ═══════════════════════════════════════
    // ✋ ACCIONES
    // ═══════════════════════════════════════
    Pictogram(id: 'act_eat', label: 'comer', emoji: '🍽️', category: 'actions', keywords: ['comida', 'almuerzo', 'cena'], sortOrder: 0),
    Pictogram(id: 'act_drink', label: 'beber', emoji: '🥤', category: 'actions', keywords: ['agua', 'líquido'], sortOrder: 1),
    Pictogram(id: 'act_play', label: 'jugar', emoji: '🎮', category: 'actions', keywords: ['diversión', 'juegos'], sortOrder: 2),
    Pictogram(id: 'act_go', label: 'ir', emoji: '🚶', category: 'actions', keywords: ['mover', 'caminar', 'salir'], sortOrder: 3),
    Pictogram(id: 'act_come', label: 'venir', emoji: '🫳', category: 'actions', keywords: ['acercarse', 'llegar'], sortOrder: 4),
    Pictogram(id: 'act_sleep', label: 'dormir', emoji: '💤', category: 'actions', keywords: ['cama', 'descansar', 'siesta'], sortOrder: 5),
    Pictogram(id: 'act_read', label: 'leer', emoji: '📖', category: 'actions', keywords: ['libro', 'cuento', 'historia'], sortOrder: 6),
    Pictogram(id: 'act_watch', label: 'ver tele', emoji: '📺', category: 'actions', keywords: ['tele', 'película', 'mirar'], sortOrder: 7),
    Pictogram(id: 'act_listen', label: 'escuchar', emoji: '🎵', category: 'actions', keywords: ['música', 'sonido', 'oír'], sortOrder: 8),
    Pictogram(id: 'act_hug', label: 'abrazo', emoji: '🤗', category: 'actions', keywords: ['cariño', 'abrazar'], sortOrder: 9),
    Pictogram(id: 'act_wash', label: 'lavar', emoji: '🚿', category: 'actions', keywords: ['duchar', 'limpiar', 'baño'], sortOrder: 10),
    Pictogram(id: 'act_dress', label: 'vestir', emoji: '👔', category: 'actions', keywords: ['ropa', 'ponerse', 'cambiar'], sortOrder: 11),
    Pictogram(id: 'act_sit', label: 'sentarse', emoji: '🪑', category: 'actions', keywords: ['silla', 'sentar'], sortOrder: 12),
    Pictogram(id: 'act_stand', label: 'levantarse', emoji: '🧍', category: 'actions', keywords: ['parar', 'arriba'], sortOrder: 13),
    Pictogram(id: 'act_open', label: 'abrir', emoji: '📭', category: 'actions', keywords: ['puerta', 'caja'], sortOrder: 14),
    Pictogram(id: 'act_close', label: 'cerrar', emoji: '📪', category: 'actions', keywords: ['puerta', 'tapar'], sortOrder: 15),
    Pictogram(id: 'act_give', label: 'dar', emoji: '🤲', category: 'actions', keywords: ['entregar', 'ofrecer'], sortOrder: 16),
    Pictogram(id: 'act_take', label: 'coger', emoji: '✊', category: 'actions', keywords: ['agarrar', 'tomar'], sortOrder: 17),
    Pictogram(id: 'act_look', label: 'mirar', emoji: '👀', category: 'actions', keywords: ['ver', 'observar'], sortOrder: 18),
    Pictogram(id: 'act_draw', label: 'dibujar', emoji: '🖍️', category: 'actions', keywords: ['pintar', 'arte', 'colorear'], sortOrder: 19),
    Pictogram(id: 'act_sing', label: 'cantar', emoji: '🎤', category: 'actions', keywords: ['música', 'voz'], sortOrder: 20),
    Pictogram(id: 'act_dance', label: 'bailar', emoji: '💃', category: 'actions', keywords: ['música', 'moverse'], sortOrder: 21),
    Pictogram(id: 'act_run', label: 'correr', emoji: '🏃', category: 'actions', keywords: ['rápido', 'deporte'], sortOrder: 22),
    Pictogram(id: 'act_swim', label: 'nadar', emoji: '🏊', category: 'actions', keywords: ['piscina', 'agua', 'playa'], sortOrder: 23),
    Pictogram(id: 'act_cook', label: 'cocinar', emoji: '👨‍🍳', category: 'actions', keywords: ['comida', 'preparar'], sortOrder: 24),
    Pictogram(id: 'act_call', label: 'llamar', emoji: '📞', category: 'actions', keywords: ['teléfono', 'hablar'], sortOrder: 25),
    Pictogram(id: 'act_work', label: 'trabajar', emoji: '💼', category: 'actions', keywords: ['oficio', 'empleo'], sortOrder: 26),
    Pictogram(id: 'act_study', label: 'estudiar', emoji: '📝', category: 'actions', keywords: ['aprender', 'deberes'], sortOrder: 27),

    // ═══════════════════════════════════════
    // 🍕 COMIDA
    // ═══════════════════════════════════════
    Pictogram(id: 'food_pizza', label: 'pizza', emoji: '🍕', category: 'food', keywords: ['comida', 'italiana'], sortOrder: 0),
    Pictogram(id: 'food_apple', label: 'manzana', emoji: '🍎', category: 'food', keywords: ['fruta', 'snack'], sortOrder: 1),
    Pictogram(id: 'food_bread', label: 'pan', emoji: '🍞', category: 'food', keywords: ['tostada', 'bocadillo'], sortOrder: 2),
    Pictogram(id: 'food_rice', label: 'arroz', emoji: '🍚', category: 'food', keywords: ['cereal', 'plato'], sortOrder: 3),
    Pictogram(id: 'food_chicken', label: 'pollo', emoji: '🍗', category: 'food', keywords: ['carne', 'proteína'], sortOrder: 4),
    Pictogram(id: 'food_egg', label: 'huevo', emoji: '🥚', category: 'food', keywords: ['tortilla', 'frito'], sortOrder: 5),
    Pictogram(id: 'food_banana', label: 'plátano', emoji: '🍌', category: 'food', keywords: ['fruta'], sortOrder: 6),
    Pictogram(id: 'food_cookie', label: 'galleta', emoji: '🍪', category: 'food', keywords: ['dulce', 'snack'], sortOrder: 7),
    Pictogram(id: 'food_cake', label: 'tarta', emoji: '🎂', category: 'food', keywords: ['dulce', 'cumpleaños'], sortOrder: 8),
    Pictogram(id: 'food_soup', label: 'sopa', emoji: '🍲', category: 'food', keywords: ['caldo', 'caliente'], sortOrder: 9),
    Pictogram(id: 'food_pasta', label: 'pasta', emoji: '🍝', category: 'food', keywords: ['espagueti', 'macarrones'], sortOrder: 10),
    Pictogram(id: 'food_cheese', label: 'queso', emoji: '🧀', category: 'food', keywords: ['lácteo'], sortOrder: 11),
    Pictogram(id: 'food_fish', label: 'pescado', emoji: '🐟', category: 'food', keywords: ['mar', 'omega'], sortOrder: 12),
    Pictogram(id: 'food_salad', label: 'ensalada', emoji: '🥗', category: 'food', keywords: ['verdura', 'sano'], sortOrder: 13),
    Pictogram(id: 'food_sandwich', label: 'bocadillo', emoji: '🥪', category: 'food', keywords: ['pan', 'bocata'], sortOrder: 14),
    Pictogram(id: 'food_fries', label: 'patatas', emoji: '🍟', category: 'food', keywords: ['fritas', 'snack'], sortOrder: 15),
    Pictogram(id: 'food_icecream', label: 'helado', emoji: '🍦', category: 'food', keywords: ['dulce', 'frío', 'postre'], sortOrder: 16),
    Pictogram(id: 'food_yogurt', label: 'yogur', emoji: '🥛', category: 'food', keywords: ['lácteo', 'snack'], sortOrder: 17),
    Pictogram(id: 'food_cereal', label: 'cereales', emoji: '🥣', category: 'food', keywords: ['desayuno', 'leche'], sortOrder: 18),
    Pictogram(id: 'food_fruit', label: 'fruta', emoji: '🍇', category: 'food', keywords: ['sano', 'postre'], sortOrder: 19),
    Pictogram(id: 'food_vegetable', label: 'verdura', emoji: '🥦', category: 'food', keywords: ['sano', 'brócoli'], sortOrder: 20),
    Pictogram(id: 'food_meat', label: 'carne', emoji: '🥩', category: 'food', keywords: ['filete', 'proteína'], sortOrder: 21),
    Pictogram(id: 'food_chocolate', label: 'chocolate', emoji: '🍫', category: 'food', keywords: ['dulce', 'snack'], sortOrder: 22),
    Pictogram(id: 'food_candy', label: 'caramelo', emoji: '🍬', category: 'food', keywords: ['dulce', 'golosina'], sortOrder: 23),

    // ═══════════════════════════════════════
    // 💧 BEBIDAS
    // ═══════════════════════════════════════
    Pictogram(id: 'drink_water', label: 'agua', emoji: '💧', category: 'drinks', keywords: ['beber', 'líquido', 'vaso'], sortOrder: 0),
    Pictogram(id: 'drink_milk', label: 'leche', emoji: '🥛', category: 'drinks', keywords: ['lácteo', 'vaso'], sortOrder: 1),
    Pictogram(id: 'drink_juice', label: 'zumo', emoji: '🧃', category: 'drinks', keywords: ['fruta', 'jugo'], sortOrder: 2),
    Pictogram(id: 'drink_tea', label: 'té', emoji: '🍵', category: 'drinks', keywords: ['infusión', 'caliente'], sortOrder: 3),
    Pictogram(id: 'drink_hot_choc', label: 'chocolate', emoji: '☕', category: 'drinks', keywords: ['cacao', 'caliente', 'ColaCao'], sortOrder: 4),
    Pictogram(id: 'drink_soda', label: 'refresco', emoji: '🥤', category: 'drinks', keywords: ['gaseosa', 'cola', 'fanta'], sortOrder: 5),
    Pictogram(id: 'drink_smoothie', label: 'batido', emoji: '🥤', category: 'drinks', keywords: ['fruta', 'leche'], sortOrder: 6),
    Pictogram(id: 'drink_coffee', label: 'café', emoji: '☕', category: 'drinks', keywords: ['cafeína', 'mañana'], sortOrder: 7),

    // ═══════════════════════════════════════
    // 🏠 LUGARES
    // ═══════════════════════════════════════
    Pictogram(id: 'place_home', label: 'casa', emoji: '🏠', category: 'places', keywords: ['hogar', 'ir'], sortOrder: 0),
    Pictogram(id: 'place_hospital', label: 'hospital', emoji: '🏥', category: 'places', keywords: ['médico', 'doctor'], sortOrder: 1),
    Pictogram(id: 'place_school', label: 'colegio', emoji: '🏫', category: 'places', keywords: ['clase', 'estudiar'], sortOrder: 2),
    Pictogram(id: 'place_park', label: 'parque', emoji: '🌳', category: 'places', keywords: ['jugar', 'fuera', 'paseo'], sortOrder: 3),
    Pictogram(id: 'place_bathroom', label: 'baño', emoji: '🚽', category: 'places', keywords: ['lavabo', 'necesidad'], sortOrder: 4),
    Pictogram(id: 'place_bed', label: 'cama', emoji: '🛏️', category: 'places', keywords: ['dormir', 'habitación'], sortOrder: 5),
    Pictogram(id: 'place_car', label: 'coche', emoji: '🚗', category: 'places', keywords: ['viajar', 'ir', 'transporte'], sortOrder: 6),
    Pictogram(id: 'place_store', label: 'tienda', emoji: '🏪', category: 'places', keywords: ['comprar', 'supermercado'], sortOrder: 7),
    Pictogram(id: 'place_beach', label: 'playa', emoji: '🏖️', category: 'places', keywords: ['arena', 'mar', 'vacaciones'], sortOrder: 8),
    Pictogram(id: 'place_kitchen', label: 'cocina', emoji: '🍳', category: 'places', keywords: ['comida', 'preparar'], sortOrder: 9),
    Pictogram(id: 'place_garden', label: 'jardín', emoji: '🌻', category: 'places', keywords: ['fuera', 'flores', 'patio'], sortOrder: 10),
    Pictogram(id: 'place_pool', label: 'piscina', emoji: '🏊', category: 'places', keywords: ['nadar', 'agua'], sortOrder: 11),
    Pictogram(id: 'place_restaurant', label: 'restaurante', emoji: '🍽️', category: 'places', keywords: ['comer', 'fuera'], sortOrder: 12),
    Pictogram(id: 'place_church', label: 'iglesia', emoji: '⛪', category: 'places', keywords: ['rezar', 'misa'], sortOrder: 13),
    Pictogram(id: 'place_bus', label: 'autobús', emoji: '🚌', category: 'places', keywords: ['transporte', 'viajar'], sortOrder: 14),

    // ═══════════════════════════════════════
    // 👨‍👩‍👧 PERSONAS
    // ═══════════════════════════════════════
    Pictogram(id: 'people_mom', label: 'mamá', emoji: '👩', category: 'people', keywords: ['madre', 'mami'], sortOrder: 0),
    Pictogram(id: 'people_dad', label: 'papá', emoji: '👨', category: 'people', keywords: ['padre', 'papi'], sortOrder: 1),
    Pictogram(id: 'people_brother', label: 'hermano', emoji: '👦', category: 'people', keywords: ['familia', 'chico'], sortOrder: 2),
    Pictogram(id: 'people_sister', label: 'hermana', emoji: '👧', category: 'people', keywords: ['familia', 'chica'], sortOrder: 3),
    Pictogram(id: 'people_baby', label: 'bebé', emoji: '👶', category: 'people', keywords: ['hermano', 'pequeño'], sortOrder: 4),
    Pictogram(id: 'people_grandma', label: 'abuela', emoji: '👵', category: 'people', keywords: ['yaya', 'abuelita'], sortOrder: 5),
    Pictogram(id: 'people_grandpa', label: 'abuelo', emoji: '👴', category: 'people', keywords: ['yayo', 'abuelito'], sortOrder: 6),
    Pictogram(id: 'people_doctor', label: 'doctor', emoji: '🧑‍⚕️', category: 'people', keywords: ['médico', 'hospital'], sortOrder: 7),
    Pictogram(id: 'people_teacher', label: 'profesor', emoji: '👩‍🏫', category: 'people', keywords: ['maestro', 'clase'], sortOrder: 8),
    Pictogram(id: 'people_friend', label: 'amigo', emoji: '🧑‍🤝‍🧑', category: 'people', keywords: ['compañero', 'jugar'], sortOrder: 9),
    Pictogram(id: 'people_dog', label: 'perro', emoji: '🐕', category: 'people', keywords: ['mascota', 'animal'], sortOrder: 10),
    Pictogram(id: 'people_cat', label: 'gato', emoji: '🐈', category: 'people', keywords: ['mascota', 'animal'], sortOrder: 11),
    Pictogram(id: 'people_uncle', label: 'tío/tía', emoji: '👫', category: 'people', keywords: ['familia', 'tío'], sortOrder: 12),
    Pictogram(id: 'people_neighbor', label: 'vecino', emoji: '🏘️', category: 'people', keywords: ['cerca', 'barrio'], sortOrder: 13),
    Pictogram(id: 'people_caretaker', label: 'cuidador', emoji: '🧑‍🦽', category: 'people', keywords: ['asistente', 'enfermero'], sortOrder: 14),

    // ═══════════════════════════════════════
    // 🦷 CUERPO
    // ═══════════════════════════════════════
    Pictogram(id: 'body_head', label: 'cabeza', emoji: '🗣️', category: 'body', keywords: ['cara', 'dolor de cabeza'], sortOrder: 0),
    Pictogram(id: 'body_tummy', label: 'barriga', emoji: '🤢', category: 'body', keywords: ['estómago', 'tripa', 'dolor'], sortOrder: 1),
    Pictogram(id: 'body_tooth', label: 'diente', emoji: '🦷', category: 'body', keywords: ['muela', 'boca', 'dolor'], sortOrder: 2),
    Pictogram(id: 'body_hand', label: 'mano', emoji: '✋', category: 'body', keywords: ['brazo', 'dedo'], sortOrder: 3),
    Pictogram(id: 'body_foot', label: 'pie', emoji: '🦶', category: 'body', keywords: ['pierna', 'caminar'], sortOrder: 4),
    Pictogram(id: 'body_eye', label: 'ojo', emoji: '👁️', category: 'body', keywords: ['ver', 'mirar'], sortOrder: 5),
    Pictogram(id: 'body_ear', label: 'oreja', emoji: '👂', category: 'body', keywords: ['oír', 'escuchar'], sortOrder: 6),
    Pictogram(id: 'body_back', label: 'espalda', emoji: '🔙', category: 'body', keywords: ['dolor', 'columna'], sortOrder: 7),
    Pictogram(id: 'body_throat', label: 'garganta', emoji: '🤧', category: 'body', keywords: ['dolor', 'tragar', 'tos'], sortOrder: 8),
    Pictogram(id: 'body_nose', label: 'nariz', emoji: '👃', category: 'body', keywords: ['oler', 'mocos', 'respirar'], sortOrder: 9),
    Pictogram(id: 'body_chest', label: 'pecho', emoji: '💓', category: 'body', keywords: ['corazón', 'respirar', 'dolor'], sortOrder: 10),
    Pictogram(id: 'body_knee', label: 'rodilla', emoji: '🦵', category: 'body', keywords: ['pierna', 'dolor'], sortOrder: 11),

    // ═══════════════════════════════════════
    // 🕐 TIEMPO
    // ═══════════════════════════════════════
    Pictogram(id: 'time_now', label: 'ahora', emoji: '⏰', category: 'time', keywords: ['ya', 'momento'], sortOrder: 0),
    Pictogram(id: 'time_later', label: 'después', emoji: '🕐', category: 'time', keywords: ['luego', 'más tarde'], sortOrder: 1),
    Pictogram(id: 'time_morning', label: 'mañana (AM)', emoji: '🌅', category: 'time', keywords: ['amanecer', 'día'], sortOrder: 2),
    Pictogram(id: 'time_afternoon', label: 'tarde', emoji: '🌇', category: 'time', keywords: ['mediodía', 'siesta'], sortOrder: 3),
    Pictogram(id: 'time_night', label: 'noche', emoji: '🌙', category: 'time', keywords: ['oscuro', 'dormir'], sortOrder: 4),
    Pictogram(id: 'time_yesterday', label: 'ayer', emoji: '⬅️', category: 'time', keywords: ['pasado'], sortOrder: 5),
    Pictogram(id: 'time_tomorrow', label: 'mañana', emoji: '➡️', category: 'time', keywords: ['futuro', 'próximo'], sortOrder: 6),
    Pictogram(id: 'time_today', label: 'hoy', emoji: '📅', category: 'time', keywords: ['ahora', 'este día'], sortOrder: 7),
    Pictogram(id: 'time_weekend', label: 'fin de semana', emoji: '🎉', category: 'time', keywords: ['sábado', 'domingo', 'fiesta'], sortOrder: 8),
    Pictogram(id: 'time_always', label: 'siempre', emoji: '♾️', category: 'time', keywords: ['todo', 'constante'], sortOrder: 9),
    Pictogram(id: 'time_never', label: 'nunca', emoji: '🚫', category: 'time', keywords: ['jamás', 'ninguno'], sortOrder: 10),
    Pictogram(id: 'time_before', label: 'antes', emoji: '⏪', category: 'time', keywords: ['primero', 'previo'], sortOrder: 11),

    // ═══════════════════════════════════════
    // 📱 OBJETOS
    // ═══════════════════════════════════════
    Pictogram(id: 'obj_phone', label: 'teléfono', emoji: '📱', category: 'objects', keywords: ['llamar', 'móvil'], sortOrder: 0),
    Pictogram(id: 'obj_toy', label: 'juguete', emoji: '🧸', category: 'objects', keywords: ['peluche', 'jugar'], sortOrder: 1),
    Pictogram(id: 'obj_ball', label: 'pelota', emoji: '⚽', category: 'objects', keywords: ['fútbol', 'jugar', 'deporte'], sortOrder: 2),
    Pictogram(id: 'obj_book', label: 'libro', emoji: '📚', category: 'objects', keywords: ['leer', 'cuento'], sortOrder: 3),
    Pictogram(id: 'obj_clothes', label: 'ropa', emoji: '👕', category: 'objects', keywords: ['vestir', 'camiseta'], sortOrder: 4),
    Pictogram(id: 'obj_medicine', label: 'medicina', emoji: '💊', category: 'objects', keywords: ['pastilla', 'remedio', 'medicamento'], sortOrder: 5),
    Pictogram(id: 'obj_glasses', label: 'gafas', emoji: '👓', category: 'objects', keywords: ['ver', 'lentes'], sortOrder: 6),
    Pictogram(id: 'obj_tv', label: 'televisión', emoji: '📺', category: 'objects', keywords: ['ver', 'dibujos', 'peli'], sortOrder: 7),
    Pictogram(id: 'obj_tablet', label: 'tablet', emoji: '📲', category: 'objects', keywords: ['jugar', 'ver', 'pantalla'], sortOrder: 8),
    Pictogram(id: 'obj_wheelchair', label: 'silla de ruedas', emoji: '🦽', category: 'objects', keywords: ['movilidad', 'transporte'], sortOrder: 9),
    Pictogram(id: 'obj_blanket', label: 'manta', emoji: '🛌', category: 'objects', keywords: ['frío', 'cama', 'tapar'], sortOrder: 10),
    Pictogram(id: 'obj_key', label: 'llave', emoji: '🔑', category: 'objects', keywords: ['abrir', 'puerta', 'casa'], sortOrder: 11),
    Pictogram(id: 'obj_money', label: 'dinero', emoji: '💰', category: 'objects', keywords: ['comprar', 'pagar', 'euros'], sortOrder: 12),
    Pictogram(id: 'obj_bag', label: 'bolsa', emoji: '🎒', category: 'objects', keywords: ['mochila', 'llevar'], sortOrder: 13),
    Pictogram(id: 'obj_umbrella', label: 'paraguas', emoji: '☂️', category: 'objects', keywords: ['lluvia', 'mojado'], sortOrder: 14),

    // ═══════════════════════════════════════
    // 🎨 ADJETIVOS (nueva categoría)
    // ═══════════════════════════════════════
    Pictogram(id: 'adj_big', label: 'grande', emoji: '🔺', category: 'adjectives', keywords: ['enorme', 'mucho'], sortOrder: 0),
    Pictogram(id: 'adj_small', label: 'pequeño', emoji: '🔹', category: 'adjectives', keywords: ['poco', 'chico', 'mini'], sortOrder: 1),
    Pictogram(id: 'adj_hot', label: 'caliente', emoji: '🔥', category: 'adjectives', keywords: ['calor', 'temperatura'], sortOrder: 2),
    Pictogram(id: 'adj_cold', label: 'frío', emoji: '🥶', category: 'adjectives', keywords: ['helado', 'temperatura'], sortOrder: 3),
    Pictogram(id: 'adj_good', label: 'bueno', emoji: '👍', category: 'adjectives', keywords: ['bien', 'rico', 'genial'], sortOrder: 4),
    Pictogram(id: 'adj_bad', label: 'malo', emoji: '👎', category: 'adjectives', keywords: ['mal', 'feo', 'horrible'], sortOrder: 5),
    Pictogram(id: 'adj_fast', label: 'rápido', emoji: '⚡', category: 'adjectives', keywords: ['veloz', 'deprisa'], sortOrder: 6),
    Pictogram(id: 'adj_slow', label: 'despacio', emoji: '🐌', category: 'adjectives', keywords: ['lento', 'tranquilo'], sortOrder: 7),
    Pictogram(id: 'adj_new', label: 'nuevo', emoji: '✨', category: 'adjectives', keywords: ['diferente', 'otro'], sortOrder: 8),
    Pictogram(id: 'adj_old', label: 'viejo', emoji: '🏚️', category: 'adjectives', keywords: ['antiguo', 'roto'], sortOrder: 9),
    Pictogram(id: 'adj_wet', label: 'mojado', emoji: '💦', category: 'adjectives', keywords: ['agua', 'húmedo'], sortOrder: 10),
    Pictogram(id: 'adj_dry', label: 'seco', emoji: '☀️', category: 'adjectives', keywords: ['secar', 'toalla'], sortOrder: 11),
    Pictogram(id: 'adj_clean', label: 'limpio', emoji: '🧼', category: 'adjectives', keywords: ['lavar', 'aseo'], sortOrder: 12),
    Pictogram(id: 'adj_dirty', label: 'sucio', emoji: '🤢', category: 'adjectives', keywords: ['mancha', 'lavar'], sortOrder: 13),
    Pictogram(id: 'adj_loud', label: 'fuerte', emoji: '🔊', category: 'adjectives', keywords: ['ruido', 'alto'], sortOrder: 14),
    Pictogram(id: 'adj_quiet', label: 'silencio', emoji: '🤫', category: 'adjectives', keywords: ['callado', 'bajo'], sortOrder: 15),

    // ═══════════════════════════════════════
    // 💬 SOCIAL (nueva categoría)
    // ═══════════════════════════════════════
    Pictogram(id: 'soc_hello', label: 'hola', emoji: '👋', category: 'social', keywords: ['saludo', 'buenos días'], sortOrder: 0),
    Pictogram(id: 'soc_bye', label: 'adiós', emoji: '🫡', category: 'social', keywords: ['despedida', 'hasta luego'], sortOrder: 1),
    Pictogram(id: 'soc_good_morning', label: 'buenos días', emoji: '🌞', category: 'social', keywords: ['mañana', 'saludo'], sortOrder: 2),
    Pictogram(id: 'soc_good_night', label: 'buenas noches', emoji: '🌜', category: 'social', keywords: ['dormir', 'despedida'], sortOrder: 3),
    Pictogram(id: 'soc_like', label: 'me gusta', emoji: '💖', category: 'social', keywords: ['gustar', 'encanta', 'favorito'], sortOrder: 4),
    Pictogram(id: 'soc_dislike', label: 'no me gusta', emoji: '💔', category: 'social', keywords: ['disgustar', 'odiar'], sortOrder: 5),
    Pictogram(id: 'soc_miss', label: 'te echo de menos', emoji: '🥺', category: 'social', keywords: ['extrañar', 'querer ver'], sortOrder: 6),
    Pictogram(id: 'soc_happy_birthday', label: 'feliz cumpleaños', emoji: '🎂', category: 'social', keywords: ['fiesta', 'celebrar'], sortOrder: 7),
    Pictogram(id: 'soc_well_done', label: 'bien hecho', emoji: '🌟', category: 'social', keywords: ['bravo', 'genial', 'premio'], sortOrder: 8),
    Pictogram(id: 'soc_love_you', label: 'te quiero', emoji: '💕', category: 'social', keywords: ['amor', 'cariño', 'familia'], sortOrder: 9),
    Pictogram(id: 'soc_together', label: 'juntos', emoji: '🤝', category: 'social', keywords: ['compañía', 'equipo'], sortOrder: 10),
    Pictogram(id: 'soc_alone', label: 'solo', emoji: '🧍', category: 'social', keywords: ['soledad', 'tranquilo'], sortOrder: 11),
    Pictogram(id: 'soc_share', label: 'compartir', emoji: '🤲', category: 'social', keywords: ['dar', 'juntos'], sortOrder: 12),
    Pictogram(id: 'soc_stop', label: 'para', emoji: '🛑', category: 'social', keywords: ['basta', 'detener', 'no más'], sortOrder: 13),
  ];

  /// Get pictograms for a specific category
  static List<Pictogram> getByCategory(String categoryId) {
    return allPictograms
        .where((p) => p.category == categoryId)
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }
}

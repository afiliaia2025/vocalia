import '../models/pictogram.dart';

/// Provides the built-in pictogram library organized by categories.
/// In production, this would be backed by ARASAAC API + Firestore.
class PictogramData {

  static const List<PictogramCategory> categories = [
    PictogramCategory(id: 'emotions', name: 'Emociones', emoji: '😊', sortOrder: 0),
    PictogramCategory(id: 'food', name: 'Comida', emoji: '🍕', sortOrder: 1),
    PictogramCategory(id: 'drinks', name: 'Bebidas', emoji: '💧', sortOrder: 2),
    PictogramCategory(id: 'places', name: 'Lugares', emoji: '🏠', sortOrder: 3),
    PictogramCategory(id: 'people', name: 'Personas', emoji: '👨‍👩‍👧', sortOrder: 4),
    PictogramCategory(id: 'actions', name: 'Acciones', emoji: '✋', sortOrder: 5),
    PictogramCategory(id: 'body', name: 'Cuerpo', emoji: '🦷', sortOrder: 6),
    PictogramCategory(id: 'time', name: 'Tiempo', emoji: '🕐', sortOrder: 7),
    PictogramCategory(id: 'objects', name: 'Objetos', emoji: '📱', sortOrder: 8),
  ];

  static const List<Pictogram> allPictograms = [
    // ─── Emociones ───
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

    // ─── Comida ───
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

    // ─── Bebidas ───
    Pictogram(id: 'drink_water', label: 'agua', emoji: '💧', category: 'drinks', keywords: ['beber', 'líquido', 'vaso'], sortOrder: 0),
    Pictogram(id: 'drink_milk', label: 'leche', emoji: '🥛', category: 'drinks', keywords: ['lácteo', 'vaso'], sortOrder: 1),
    Pictogram(id: 'drink_juice', label: 'zumo', emoji: '🧃', category: 'drinks', keywords: ['fruta', 'jugo'], sortOrder: 2),
    Pictogram(id: 'drink_tea', label: 'té', emoji: '🍵', category: 'drinks', keywords: ['infusión', 'caliente'], sortOrder: 3),
    Pictogram(id: 'drink_chocolate', label: 'chocolate', emoji: '🍫', category: 'drinks', keywords: ['cacao', 'caliente'], sortOrder: 4),

    // ─── Lugares ───
    Pictogram(id: 'place_home', label: 'casa', emoji: '🏠', category: 'places', keywords: ['hogar', 'ir'], sortOrder: 0),
    Pictogram(id: 'place_hospital', label: 'hospital', emoji: '🏥', category: 'places', keywords: ['médico', 'doctor'], sortOrder: 1),
    Pictogram(id: 'place_school', label: 'colegio', emoji: '🏫', category: 'places', keywords: ['clase', 'estudiar'], sortOrder: 2),
    Pictogram(id: 'place_park', label: 'parque', emoji: '🌳', category: 'places', keywords: ['jugar', 'fuera', 'paseo'], sortOrder: 3),
    Pictogram(id: 'place_bathroom', label: 'baño', emoji: '🚽', category: 'places', keywords: ['lavabo', 'necesidad'], sortOrder: 4),
    Pictogram(id: 'place_bed', label: 'cama', emoji: '🛏️', category: 'places', keywords: ['dormir', 'habitación'], sortOrder: 5),
    Pictogram(id: 'place_car', label: 'coche', emoji: '🚗', category: 'places', keywords: ['viajar', 'ir', 'transporte'], sortOrder: 6),
    Pictogram(id: 'place_store', label: 'tienda', emoji: '🏪', category: 'places', keywords: ['comprar', 'supermercado'], sortOrder: 7),
    Pictogram(id: 'place_beach', label: 'playa', emoji: '🏖️', category: 'places', keywords: ['arena', 'mar', 'vacaciones'], sortOrder: 8),

    // ─── Personas ───
    Pictogram(id: 'people_mom', label: 'mamá', emoji: '👩', category: 'people', keywords: ['madre', 'mami'], sortOrder: 0),
    Pictogram(id: 'people_dad', label: 'papá', emoji: '👨', category: 'people', keywords: ['padre', 'papi'], sortOrder: 1),
    Pictogram(id: 'people_baby', label: 'bebé', emoji: '👶', category: 'people', keywords: ['hermano', 'pequeño'], sortOrder: 2),
    Pictogram(id: 'people_doctor', label: 'doctor', emoji: '🧑‍⚕️', category: 'people', keywords: ['médico', 'hospital'], sortOrder: 3),
    Pictogram(id: 'people_teacher', label: 'profesor', emoji: '👩‍🏫', category: 'people', keywords: ['maestro', 'clase'], sortOrder: 4),
    Pictogram(id: 'people_friend', label: 'amigo', emoji: '🧑‍🤝‍🧑', category: 'people', keywords: ['compañero', 'jugar'], sortOrder: 5),
    Pictogram(id: 'people_dog', label: 'perro', emoji: '🐕', category: 'people', keywords: ['mascota', 'animal'], sortOrder: 6),
    Pictogram(id: 'people_cat', label: 'gato', emoji: '🐈', category: 'people', keywords: ['mascota', 'animal'], sortOrder: 7),
    Pictogram(id: 'people_grandma', label: 'abuela', emoji: '👵', category: 'people', keywords: ['yaya', 'abuelita'], sortOrder: 8),
    Pictogram(id: 'people_grandpa', label: 'abuelo', emoji: '👴', category: 'people', keywords: ['yayo', 'abuelito'], sortOrder: 9),

    // ─── Acciones ───
    Pictogram(id: 'act_want', label: 'quiero', emoji: '👉', category: 'actions', keywords: ['deseo', 'pedir'], sortOrder: 0),
    Pictogram(id: 'act_no', label: 'no', emoji: '🚫', category: 'actions', keywords: ['negar', 'rechazar', 'no quiero'], sortOrder: 1),
    Pictogram(id: 'act_yes', label: 'sí', emoji: '✅', category: 'actions', keywords: ['afirmar', 'aceptar', 'vale'], sortOrder: 2),
    Pictogram(id: 'act_eat', label: 'comer', emoji: '🍽️', category: 'actions', keywords: ['comida', 'almuerzo', 'cena'], sortOrder: 3),
    Pictogram(id: 'act_drink', label: 'beber', emoji: '🥤', category: 'actions', keywords: ['agua', 'líquido'], sortOrder: 4),
    Pictogram(id: 'act_play', label: 'jugar', emoji: '🎮', category: 'actions', keywords: ['diversión', 'juegos'], sortOrder: 5),
    Pictogram(id: 'act_go', label: 'ir', emoji: '🚶', category: 'actions', keywords: ['mover', 'caminar', 'salir'], sortOrder: 6),
    Pictogram(id: 'act_help', label: 'ayuda', emoji: '🆘', category: 'actions', keywords: ['socorro', 'necesitar', 'urgente'], sortOrder: 7),
    Pictogram(id: 'act_sleep', label: 'dormir', emoji: '💤', category: 'actions', keywords: ['cama', 'descansar', 'siesta'], sortOrder: 8),
    Pictogram(id: 'act_read', label: 'leer', emoji: '📖', category: 'actions', keywords: ['libro', 'cuento', 'historia'], sortOrder: 9),
    Pictogram(id: 'act_watch', label: 'ver', emoji: '📺', category: 'actions', keywords: ['tele', 'película', 'mirar'], sortOrder: 10),
    Pictogram(id: 'act_listen', label: 'escuchar', emoji: '🎵', category: 'actions', keywords: ['música', 'sonido', 'oír'], sortOrder: 11),
    Pictogram(id: 'act_hug', label: 'abrazo', emoji: '🤗', category: 'actions', keywords: ['cariño', 'abrazar'], sortOrder: 12),

    // ─── Cuerpo ───
    Pictogram(id: 'body_head', label: 'cabeza', emoji: '🗣️', category: 'body', keywords: ['cara', 'dolor de cabeza'], sortOrder: 0),
    Pictogram(id: 'body_tummy', label: 'barriga', emoji: '🤢', category: 'body', keywords: ['estómago', 'tripa', 'dolor'], sortOrder: 1),
    Pictogram(id: 'body_tooth', label: 'diente', emoji: '🦷', category: 'body', keywords: ['muela', 'boca', 'dolor'], sortOrder: 2),
    Pictogram(id: 'body_hand', label: 'mano', emoji: '✋', category: 'body', keywords: ['brazo', 'dedo'], sortOrder: 3),
    Pictogram(id: 'body_foot', label: 'pie', emoji: '🦶', category: 'body', keywords: ['pierna', 'caminar'], sortOrder: 4),
    Pictogram(id: 'body_eye', label: 'ojo', emoji: '👁️', category: 'body', keywords: ['ver', 'mirar'], sortOrder: 5),
    Pictogram(id: 'body_ear', label: 'oreja', emoji: '👂', category: 'body', keywords: ['oír', 'escuchar'], sortOrder: 6),

    // ─── Tiempo ───
    Pictogram(id: 'time_now', label: 'ahora', emoji: '⏰', category: 'time', keywords: ['ya', 'momento'], sortOrder: 0),
    Pictogram(id: 'time_later', label: 'después', emoji: '🕐', category: 'time', keywords: ['luego', 'más tarde'], sortOrder: 1),
    Pictogram(id: 'time_morning', label: 'mañana', emoji: '🌅', category: 'time', keywords: ['amanecer', 'día'], sortOrder: 2),
    Pictogram(id: 'time_night', label: 'noche', emoji: '🌙', category: 'time', keywords: ['oscuro', 'dormir'], sortOrder: 3),
    Pictogram(id: 'time_yesterday', label: 'ayer', emoji: '⬅️', category: 'time', keywords: ['pasado'], sortOrder: 4),
    Pictogram(id: 'time_tomorrow', label: 'mañana', emoji: '➡️', category: 'time', keywords: ['futuro', 'próximo'], sortOrder: 5),

    // ─── Objetos ───
    Pictogram(id: 'obj_phone', label: 'teléfono', emoji: '📱', category: 'objects', keywords: ['llamar', 'móvil'], sortOrder: 0),
    Pictogram(id: 'obj_toy', label: 'juguete', emoji: '🧸', category: 'objects', keywords: ['peluche', 'jugar'], sortOrder: 1),
    Pictogram(id: 'obj_ball', label: 'pelota', emoji: '⚽', category: 'objects', keywords: ['fútbol', 'jugar', 'deporte'], sortOrder: 2),
    Pictogram(id: 'obj_book', label: 'libro', emoji: '📚', category: 'objects', keywords: ['leer', 'cuento'], sortOrder: 3),
    Pictogram(id: 'obj_clothes', label: 'ropa', emoji: '👕', category: 'objects', keywords: ['vestir', 'camiseta'], sortOrder: 4),
    Pictogram(id: 'obj_medicine', label: 'medicina', emoji: '💊', category: 'objects', keywords: ['pastilla', 'remedio', 'medicamento'], sortOrder: 5),
    Pictogram(id: 'obj_glasses', label: 'gafas', emoji: '👓', category: 'objects', keywords: ['ver', 'lentes'], sortOrder: 6),
  ];

  /// Get pictograms for a specific category
  static List<Pictogram> getByCategory(String categoryId) {
    return allPictograms
        .where((p) => p.category == categoryId)
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }
}

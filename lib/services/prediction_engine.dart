import '../models/pictogram.dart';
import '../data/pictogram_data.dart';

/// Prediction engine for AAC communication.
/// Uses context-aware rules to suggest the most likely next pictograms
/// based on what the user has already selected.
class PredictionEngine {

  /// Maximum number of suggestions to show
  static const int maxSuggestions = 8;

  /// Get predicted next pictograms based on current selection.
  static List<Pictogram> getSuggestions(List<Pictogram> selected) {
    if (selected.isEmpty) {
      return _getDefaultSuggestions();
    }

    final last = selected.last;
    final allSelected = selected.map((p) => p.id).toSet();

    // Get context-based suggestions
    List<Pictogram> suggestions = [];

    // 1. Direct association rules (highest priority)
    final directSuggestions = _getDirectAssociations(last, selected);
    suggestions.addAll(directSuggestions);

    // 2. Category-based suggestions
    if (suggestions.length < maxSuggestions) {
      final categorySuggestions = _getCategorySuggestions(last, selected);
      suggestions.addAll(categorySuggestions);
    }

    // 3. Common completions
    if (suggestions.length < maxSuggestions) {
      final completions = _getCommonCompletions(selected);
      suggestions.addAll(completions);
    }

    // Remove duplicates and already-selected pictograms
    final seen = <String>{};
    suggestions = suggestions.where((p) {
      if (seen.contains(p.id) || allSelected.contains(p.id)) return false;
      seen.add(p.id);
      return true;
    }).toList();

    return suggestions.take(maxSuggestions).toList();
  }

  /// Default suggestions when nothing is selected — most common starters
  static List<Pictogram> _getDefaultSuggestions() {
    const starterIds = [
      'basic_want',      // quiero
      'basic_me',        // yo
      'basic_help',      // ayuda
      'soc_hello',       // hola
      'emo_hungry',      // hambre
      'emo_thirsty',     // sed
      'emo_pain',        // dolor
      'basic_please',    // por favor
    ];
    return _getByIds(starterIds);
  }

  /// Direct semantic associations: "after X, suggest Y"
  static List<Pictogram> _getDirectAssociations(Pictogram last, List<Pictogram> selected) {
    // Map of pictogram ID → list of suggested next pictogram IDs
    const Map<String, List<String>> associations = {
      // ─── QUIERO (I want) → things you can want ───
      'basic_want': [
        'act_eat', 'act_drink', 'act_play', 'act_go', 'act_sleep',
        'act_watch', 'act_hug', 'drink_water', 'food_pizza',
      ],

      // ─── NO QUIERO → things you reject ───
      'basic_no_want': [
        'act_eat', 'act_drink', 'act_sleep', 'act_go',
        'act_wash', 'obj_medicine', 'act_study',
      ],

      // ─── YO (I/me) → verbs and states ───
      'basic_me': [
        'basic_want', 'basic_no_want', 'emo_happy', 'emo_sad',
        'emo_hungry', 'emo_thirsty', 'emo_tired', 'emo_pain',
      ],

      // ─── TÚ (you) → questions about others ───
      'basic_you': [
        'basic_where', 'basic_when', 'soc_like', 'act_come',
        'act_play', 'emo_happy', 'emo_sad',
      ],

      // ─── DÓNDE (where) → places ───
      'basic_where': [
        'place_home', 'place_bathroom', 'place_school', 'place_park',
        'place_hospital', 'place_car', 'place_store', 'people_mom',
      ],

      // ─── CUÁNDO (when) → time words ───
      'basic_when': [
        'time_now', 'time_later', 'time_tomorrow', 'time_today',
        'time_morning', 'time_afternoon', 'time_night',
      ],

      // ─── COMER (eat) → food items ───
      'act_eat': [
        'food_pizza', 'food_bread', 'food_chicken', 'food_pasta',
        'food_rice', 'food_fruit', 'food_sandwich', 'food_soup',
      ],

      // ─── BEBER (drink) → drink items ───
      'act_drink': [
        'drink_water', 'drink_milk', 'drink_juice', 'drink_soda',
        'drink_hot_choc', 'drink_tea', 'drink_smoothie',
      ],

      // ─── JUGAR (play) → play-related ───
      'act_play': [
        'obj_ball', 'obj_toy', 'obj_tablet', 'place_park',
        'people_friend', 'soc_together', 'adj_fast',
      ],

      // ─── IR (go) → places ───
      'act_go': [
        'place_home', 'place_school', 'place_park', 'place_bathroom',
        'place_store', 'place_beach', 'place_hospital', 'place_restaurant',
      ],

      // ─── DORMIR (sleep) → bedtime context ───
      'act_sleep': [
        'place_bed', 'obj_blanket', 'soc_good_night', 'emo_tired',
        'time_night', 'basic_want', 'basic_no_want',
      ],

      // ─── DOLOR (pain) → body parts ───
      'emo_pain': [
        'body_head', 'body_tummy', 'body_tooth', 'body_hand',
        'body_foot', 'body_throat', 'body_back', 'body_ear',
      ],

      // ─── ENFERMO (sick) → medical context ───
      'emo_sick': [
        'place_hospital', 'people_doctor', 'obj_medicine',
        'body_head', 'body_tummy', 'body_throat', 'emo_pain',
      ],

      // ─── HAMBRE (hungry) → food ───
      'emo_hungry': [
        'act_eat', 'food_pizza', 'food_bread', 'food_fruit',
        'food_sandwich', 'food_pasta', 'basic_want', 'basic_please',
      ],

      // ─── SED (thirsty) → drinks ───
      'emo_thirsty': [
        'act_drink', 'drink_water', 'drink_juice', 'drink_milk',
        'drink_soda', 'basic_want', 'basic_please',
      ],

      // ─── HOLA → social follow-ups ───
      'soc_hello': [
        'people_mom', 'people_dad', 'people_friend', 'people_teacher',
        'soc_good_morning', 'basic_me', 'emo_happy',
      ],

      // ─── ADIÓS → farewell context ───
      'soc_bye': [
        'soc_love_you', 'soc_good_night', 'soc_miss',
        'act_go', 'place_home', 'time_later',
      ],

      // ─── ME GUSTA → things to like ───
      'soc_like': [
        'act_play', 'act_eat', 'act_watch', 'act_swim',
        'act_draw', 'act_sing', 'food_icecream', 'food_chocolate',
      ],

      // ─── AYUDA → urgent contexts ───
      'basic_help': [
        'basic_please', 'emo_pain', 'emo_scared', 'emo_sick',
        'people_mom', 'people_dad', 'people_doctor', 'place_bathroom',
      ],

      // ─── MÁS → repeat actions ───
      'basic_more': [
        'act_eat', 'act_drink', 'act_play', 'food_pizza',
        'drink_water', 'food_cookie', 'basic_please',
      ],

      // ─── POR FAVOR → polite requests ───
      'basic_please': [
        'basic_want', 'act_eat', 'act_drink', 'act_play',
        'act_go', 'basic_help', 'basic_more',
      ],

      // ─── Body parts → pain/discomfort ───
      'body_head': ['emo_pain', 'emo_sick', 'obj_medicine', 'people_doctor'],
      'body_tummy': ['emo_pain', 'emo_sick', 'act_eat', 'place_bathroom'],
      'body_tooth': ['emo_pain', 'people_doctor', 'obj_medicine'],
      'body_throat': ['emo_pain', 'emo_sick', 'act_drink', 'obj_medicine'],

      // ─── People → actions with them ───
      'people_mom': ['soc_love_you', 'basic_want', 'act_hug', 'soc_miss', 'basic_where'],
      'people_dad': ['soc_love_you', 'basic_want', 'act_hug', 'soc_miss', 'act_play'],
      'people_friend': ['act_play', 'soc_hello', 'act_go', 'soc_together', 'soc_like'],
      'people_doctor': ['emo_pain', 'emo_sick', 'body_tummy', 'obj_medicine', 'place_hospital'],

      // ─── Places → actions at those places ───
      'place_home': ['act_go', 'basic_want', 'time_now', 'people_mom', 'people_dad'],
      'place_park': ['act_play', 'act_run', 'act_swim', 'people_friend', 'obj_ball'],
      'place_school': ['act_study', 'people_teacher', 'people_friend', 'act_read'],
      'place_bathroom': ['basic_want', 'act_go', 'time_now', 'basic_help'],

      // ─── Food items → adjectives and more ───
      'food_pizza': ['basic_more', 'soc_like', 'adj_good', 'basic_please', 'basic_thanks'],
      'food_icecream': ['basic_more', 'soc_like', 'adj_cold', 'adj_good', 'basic_please'],

      // ─── Time → follow-ups ───
      'time_now': ['basic_want', 'act_go', 'act_eat', 'act_play', 'basic_please'],
      'time_later': ['act_play', 'act_go', 'basic_want', 'time_afternoon'],
    };

    final ids = associations[last.id];
    if (ids == null) return [];
    return _getByIds(ids);
  }

  /// Suggest pictograms from semantically related categories
  static List<Pictogram> _getCategorySuggestions(Pictogram last, List<Pictogram> selected) {
    // Map category of last selected → suggested categories
    const Map<String, List<String>> categoryFlow = {
      'basic':      ['actions', 'emotions', 'food', 'places', 'people'],
      'emotions':   ['body', 'actions', 'people', 'basic'],
      'actions':    ['food', 'drinks', 'places', 'objects', 'people'],
      'food':       ['adjectives', 'basic', 'drinks', 'social'],
      'drinks':     ['adjectives', 'basic', 'social'],
      'places':     ['actions', 'people', 'time', 'basic'],
      'people':     ['actions', 'social', 'emotions', 'basic'],
      'body':       ['emotions', 'people', 'actions', 'basic'],
      'time':       ['actions', 'places', 'basic'],
      'objects':    ['actions', 'adjectives', 'basic'],
      'adjectives': ['basic', 'social', 'food'],
      'social':     ['people', 'emotions', 'time', 'basic'],
    };

    final targetCategories = categoryFlow[last.category] ?? ['basic'];
    List<Pictogram> results = [];

    for (final catId in targetCategories) {
      if (results.length >= maxSuggestions) break;
      final catPictograms = PictogramData.getByCategory(catId);
      // Take top 2 from each suggested category
      results.addAll(catPictograms.take(2));
    }

    return results;
  }

  /// Common phrase completions — suggest endings for common patterns
  static List<Pictogram> _getCommonCompletions(List<Pictogram> selected) {
    if (selected.length < 2) return [];

    final categories = selected.map((p) => p.category).toList();

    // Pattern: "emotion" → suggest "people" or "body" or "basic"
    if (categories.last == 'emotions') {
      return _getByIds(['basic_help', 'people_mom', 'people_dad', 'obj_medicine']);
    }

    // Pattern: action + food/drink → suggest thanks/more/done
    if (categories.contains('actions') &&
        (categories.contains('food') || categories.contains('drinks'))) {
      return _getByIds(['basic_thanks', 'basic_more', 'basic_done', 'adj_good']);
    }

    // Pattern: person + action → suggest place or time
    if (categories.contains('people') && categories.contains('actions')) {
      return _getByIds(['time_now', 'time_later', 'place_home', 'place_park', 'basic_please']);
    }

    // Default: suggest closers
    return _getByIds(['basic_please', 'basic_thanks', 'basic_done']);
  }

  /// Helper: get pictograms by a list of IDs
  static List<Pictogram> _getByIds(List<String> ids) {
    final allMap = {for (var p in PictogramData.allPictograms) p.id: p};
    return ids
        .where((id) => allMap.containsKey(id))
        .map((id) => allMap[id]!)
        .toList();
  }
}

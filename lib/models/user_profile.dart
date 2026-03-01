/// User profile model for adaptive configuration.
/// Stores the user's abilities, preferences, and communication needs.
class UserProfile {
  final String name;
  final int age;
  final MotorAbility motorAbility;
  final CognitiveLevel cognitiveLevel;
  final List<CommunicationNeed> communicationNeeds;
  final double pictogramScale; // 1.0 = normal, 1.5 = large, 2.0 = XL
  final int autoSpeakDelayMs;
  final int gridColumns;
  final bool showPredictions;

  const UserProfile({
    required this.name,
    required this.age,
    required this.motorAbility,
    required this.cognitiveLevel,
    required this.communicationNeeds,
    this.pictogramScale = 1.0,
    this.autoSpeakDelayMs = 1800,
    this.gridColumns = 3,
    this.showPredictions = true,
  });

  /// Generate an optimal profile from onboarding answers
  factory UserProfile.fromOnboarding({
    required String name,
    required int age,
    required MotorAbility motorAbility,
    required CognitiveLevel cognitiveLevel,
    required List<CommunicationNeed> communicationNeeds,
  }) {
    // Adaptive defaults based on abilities
    double scale = 1.0;
    int columns = 3;
    int speakDelay = 1800;

    // Motor ability → pictogram size & grid
    switch (motorAbility) {
      case MotorAbility.precise:
        scale = 1.0;
        columns = 4;
        break;
      case MotorAbility.imprecise:
        scale = 1.3;
        columns = 3;
        break;
      case MotorAbility.veryLimited:
        scale = 1.6;
        columns = 2;
        speakDelay = 2500;
        break;
      case MotorAbility.noTouch:
        scale = 2.0;
        columns = 2;
        speakDelay = 3000;
        break;
    }

    // Cognitive level → simplify
    if (cognitiveLevel == CognitiveLevel.simple) {
      columns = columns > 2 ? 2 : columns;
      scale = scale < 1.5 ? 1.5 : scale;
    }

    // Age → adjust for children vs adults
    if (age < 6) {
      scale = scale < 1.3 ? 1.3 : scale;
      columns = columns > 3 ? 3 : columns;
    }

    return UserProfile(
      name: name,
      age: age,
      motorAbility: motorAbility,
      cognitiveLevel: cognitiveLevel,
      communicationNeeds: communicationNeeds,
      pictogramScale: scale,
      autoSpeakDelayMs: speakDelay,
      gridColumns: columns,
      showPredictions: cognitiveLevel != CognitiveLevel.simple,
    );
  }

  /// Default profile for first launch
  static const UserProfile defaultProfile = UserProfile(
    name: '',
    age: 10,
    motorAbility: MotorAbility.precise,
    cognitiveLevel: CognitiveLevel.full,
    communicationNeeds: [],
  );

  /// Serialize to JSON map
  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'motorAbility': motorAbility.index,
    'cognitiveLevel': cognitiveLevel.index,
    'communicationNeeds': communicationNeeds.map((e) => e.index).toList(),
    'pictogramScale': pictogramScale,
    'autoSpeakDelayMs': autoSpeakDelayMs,
    'gridColumns': gridColumns,
    'showPredictions': showPredictions,
  };

  /// Deserialize from JSON map
  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    name: json['name'] ?? '',
    age: json['age'] ?? 10,
    motorAbility: MotorAbility.values[json['motorAbility'] ?? 0],
    cognitiveLevel: CognitiveLevel.values[json['cognitiveLevel'] ?? 0],
    communicationNeeds: (json['communicationNeeds'] as List<dynamic>?)
        ?.map((e) => CommunicationNeed.values[e as int])
        .toList() ?? [],
    pictogramScale: (json['pictogramScale'] ?? 1.0).toDouble(),
    autoSpeakDelayMs: json['autoSpeakDelayMs'] ?? 1800,
    gridColumns: json['gridColumns'] ?? 3,
    showPredictions: json['showPredictions'] ?? true,
  );
}

enum MotorAbility {
  precise,      // Can touch precisely
  imprecise,    // Can touch but not precisely
  veryLimited,  // Can move phone but not touch well
  noTouch,      // Cannot touch — needs gaze/scanning
}

enum CognitiveLevel {
  full,         // Full cognitive ability
  moderate,     // Understands pictograms, needs simplification
  simple,       // Needs very simple interface, few options
}

enum CommunicationNeed {
  requestThings,    // Pedir cosas
  expressEmotions,  // Expresar emociones
  expressPain,      // Expresar dolor
  tellExperiences,  // Contar lo que ha hecho
  socialChat,       // Saludar, despedirse
  mealtime,         // Comunicar sobre comidas
  routines,         // Seguir rutinas
}

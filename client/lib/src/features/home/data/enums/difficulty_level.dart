enum DifficultyLevel { easy, medium, hard }

// Convert string to enum
DifficultyLevel stringToDifficultyLevel(String value) {
  return DifficultyLevel.values.firstWhere(
    (e) => e.name.toLowerCase() == value.toLowerCase(),
    orElse: () => DifficultyLevel.medium,
  );
}

// Convert enum to string
String difficultyLevelToString(DifficultyLevel level) {
  return level.name.toUpperCase();
}

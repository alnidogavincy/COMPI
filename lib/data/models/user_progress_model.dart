/// Model untuk menyimpan progres belajar pengguna.
class UserProgressModel {
  final List<String> completedMaterials;
  final int highestQuizScore;
  final List<String> unlockedBadges;

  const UserProgressModel({
    this.completedMaterials = const [],
    this.highestQuizScore = 0,
    this.unlockedBadges = const [],
  });

  UserProgressModel copyWith({
    List<String>? completedMaterials,
    int? highestQuizScore,
    List<String>? unlockedBadges,
  }) {
    return UserProgressModel(
      completedMaterials: completedMaterials ?? this.completedMaterials,
      highestQuizScore: highestQuizScore ?? this.highestQuizScore,
      unlockedBadges: unlockedBadges ?? this.unlockedBadges,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedMaterials': completedMaterials,
      'highestQuizScore': highestQuizScore,
      'unlockedBadges': unlockedBadges,
    };
  }

  factory UserProgressModel.fromJson(Map<String, dynamic> json) {
    return UserProgressModel(
      completedMaterials:
          List<String>.from(json['completedMaterials'] as List? ?? []),
      highestQuizScore: json['highestQuizScore'] as int? ?? 0,
      unlockedBadges:
          List<String>.from(json['unlockedBadges'] as List? ?? []),
    );
  }
}

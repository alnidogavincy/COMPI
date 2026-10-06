/// Model untuk item pada fitur mencocokkan (matching game).
class MatchItemModel {
  final String id;
  final String imageName;
  final String targetLabel;

  const MatchItemModel({
    required this.id,
    required this.imageName,
    required this.targetLabel,
  });

  MatchItemModel copyWith({
    String? id,
    String? imageName,
    String? targetLabel,
  }) {
    return MatchItemModel(
      id: id ?? this.id,
      imageName: imageName ?? this.imageName,
      targetLabel: targetLabel ?? this.targetLabel,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageName': imageName,
      'targetLabel': targetLabel,
    };
  }

  factory MatchItemModel.fromJson(Map<String, dynamic> json) {
    return MatchItemModel(
      id: json['id'] as String,
      imageName: json['imageName'] as String,
      targetLabel: json['targetLabel'] as String,
    );
  }
}

/// Model untuk materi pembelajaran per komponen.
class LearningMaterialModel {
  final String id;
  final String componentId;
  final String title;
  final String content;
  final bool isCompleted;

  const LearningMaterialModel({
    required this.id,
    required this.componentId,
    required this.title,
    required this.content,
    this.isCompleted = false,
  });

  LearningMaterialModel copyWith({
    String? id,
    String? componentId,
    String? title,
    String? content,
    bool? isCompleted,
  }) {
    return LearningMaterialModel(
      id: id ?? this.id,
      componentId: componentId ?? this.componentId,
      title: title ?? this.title,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'componentId': componentId,
      'title': title,
      'content': content,
      'isCompleted': isCompleted,
    };
  }

  factory LearningMaterialModel.fromJson(Map<String, dynamic> json) {
    return LearningMaterialModel(
      id: json['id'] as String,
      componentId: json['componentId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}

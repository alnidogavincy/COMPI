import '../dummy_data.dart';
import '../models/component_model.dart';
import '../models/learning_material_model.dart';
import '../models/quiz_question_model.dart';
import '../models/match_item_model.dart';

class ContentRepository {
  Future<List<ComponentModel>> getComponents() async {
    // In a real app, this might fetch from a database or API
    return Future.value(dummyComponents);
  }

  Future<ComponentModel?> getComponentById(String id) async {
    try {
      return dummyComponents.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<LearningMaterialModel>> getMaterialsForComponent(String componentId) async {
    return dummyMaterials.where((m) => m.componentId == componentId).toList();
  }

  Future<List<LearningMaterialModel>> getAllMaterials() async {
    return dummyMaterials;
  }

  Future<List<QuizQuestionModel>> getQuizQuestions({String? componentId}) async {
    if (componentId != null) {
      return dummyQuizQuestions.where((q) => q.componentId == componentId).toList();
    }
    return dummyQuizQuestions;
  }

  Future<List<MatchItemModel>> getMatchItems() async {
    return dummyMatchItems;
  }
}

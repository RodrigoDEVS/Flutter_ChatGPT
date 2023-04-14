import 'package:flutter/cupertino.dart';
import 'package:flutter_chatgpt/models/models_response.dart';

class ModelsProvider with ChangeNotifier {
  List<ModelsResponse> modelsList = [];

  String currentModel = 'gpt-3.5-turbo';

  List<ModelsResponse> get getModelsList {
    return modelsList;
  }

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel({required String newModel}) {
    currentModel = newModel;
  }
}

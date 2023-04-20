import 'package:flutter/cupertino.dart';
import 'package:flutter_chatgpt/models/models_response.dart';
import 'package:flutter_chatgpt/services/api_services.dart';

class ModelsProvider with ChangeNotifier {
  List<Datum> modelsList = [];

  String currentModel = 'gpt-3.5-turbo';

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel({required String newModel}) {
    currentModel = newModel;
    notifyListeners();
  }

  List<Datum> get getModelsList {
    return modelsList;
  }

  Future<List<Datum>> getAllModels() async {
    ModelsResponse models = await ApiServices.getModels();
    modelsList = models.data!;

    return modelsList;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_chatgpt/models/chat_model.dart';
import 'package:flutter_chatgpt/models/message_model.dart';
import 'package:flutter_chatgpt/services/api_services.dart';

class ChatProvider with ChangeNotifier {
  //Listado de Mensajes para el Chat
  List<Messages> chatList = [];

  List<Messages> get getChatList {
    return chatList;
  }

  addUserMsg({required Messages userMsg}) {
    chatList.add(userMsg);
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswer(
      {required List<Messages> chatList, required String currentModel}) async {
    var message = MessageModel(model: currentModel, messages: chatList);
    List<Choice> response = await ApiServices.sendMessage(message);
    chatList.addAll(response.map((e) {
      return Messages(role: e.message?.role, content: e.message?.content);
    }));
    notifyListeners();
  }
}

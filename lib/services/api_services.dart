import 'dart:convert';
import 'dart:io';

import 'package:flutter_chatgpt/models/chat_model.dart';
import 'package:flutter_chatgpt/models/message_model.dart';
import 'package:flutter_chatgpt/models/models_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String api = dotenv.env['API_KEY'] ?? '';

class ApiServices {
  static Future<ModelsResponse> getModels() async {
    var response;
    try {
      response = await http.get(Uri.parse('https://api.openai.com/v1/models'),
          headers: {'Authorization': 'Bearer $api'});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
    } catch (e) {
      print(e);
    }
    return ModelsResponse.fromJson(response.body);
  }

  static Future<List<Choice>> sendMessage(MessageModel message) async {
    var response;
    String encodedMessage = jsonEncode(message.toJson());
    List<Choice> chatList = [];
    try {
      response = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $api'
          },
          body: encodedMessage);

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
    } catch (e) {
      print(e);
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    ChatResponse respuesta = ChatResponse.fromMap(jsonResponse);
    print(respuesta.choices?[0].message?.content);
    if (respuesta.choices!.isNotEmpty) {
      chatList = List.generate(respuesta.choices!.length, (index) {
        return Choice(
            message: Message(
                role: respuesta.choices?[index].message?.role,
                content: respuesta.choices?[index].message?.content),
            index: 1);
      });
    }

    return chatList;
  }

  // static Future<List<Choice>> sendMessage(MessageModel message) async {
  //   var response;
  //   String encodedMessage = jsonEncode(message.toJson());
  //   List<Choice> chatList = [];
  //   try {
  //     response = await http.post(
  //         Uri.parse('https://api.openai.com/v1/chat/completions'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $api'
  //         },
  //         body: encodedMessage);

  //     Map jsonResponse = jsonDecode(response.body);

  //     if (jsonResponse['error'] != null) {
  //       throw HttpException(jsonResponse['error']['message']);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //   ChatResponse respuesta = ChatResponse.fromMap(jsonResponse);
  //   print(respuesta.choices?[0].message?.content);
  //   if (respuesta.choices!.isNotEmpty) {
  //     chatList = List.generate(respuesta.choices!.length, (index) {
  //       return Choice(
  //           message: Message(
  //               role: respuesta.choices?[index].message?.role,
  //               content: respuesta.choices?[index].message?.content),
  //           index: 1);
  //     });
  //   }

  //   return chatList;
  // }
}

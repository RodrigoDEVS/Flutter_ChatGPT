import 'dart:convert';
import 'dart:io';

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
}

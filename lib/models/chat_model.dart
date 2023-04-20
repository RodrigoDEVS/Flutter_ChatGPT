// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromMap(jsonString);

import 'dart:convert';

class ChatResponse {
  ChatResponse({
    this.id,
    this.object,
    this.created,
    this.model,
    this.usage,
    this.choices,
  });

  String? id;
  String? object;
  int? created;
  String? model;
  Usage? usage;
  List<Choice>? choices;

  factory ChatResponse.fromJson(String str) =>
      ChatResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatResponse.fromMap(Map<String, dynamic> json) => ChatResponse(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        usage: Usage.fromMap(json["usage"]),
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "usage": usage!.toMap(),
        "choices": List<dynamic>.from(choices!.map((x) => x.toMap())),
      };
}

class Choice {
  Choice({
    this.message,
    this.finishReason,
    this.index,
  });

  Message? message;
  String? finishReason;
  int? index;

  factory Choice.fromJson(String str) => Choice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Choice.fromMap(Map<String, dynamic> json) => Choice(
        message: Message.fromMap(json["message"]),
        finishReason: json["finish_reason"],
        index: json["index"],
      );

  Map<String, dynamic> toMap() => {
        "message": message!.toMap(),
        "finish_reason": finishReason,
        "index": index,
      };
}

class Message {
  Message({
    this.role,
    this.content,
  });

  String? role;
  String? content;

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toMap() => {
        "role": role,
        "content": content,
      };
}

class Usage {
  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  factory Usage.fromJson(String str) => Usage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usage.fromMap(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
      );

  Map<String, dynamic> toMap() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}

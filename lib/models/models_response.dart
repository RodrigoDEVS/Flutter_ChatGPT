// To parse this JSON data, do
//
//     final modelsResponse = modelsResponseFromMap(jsonString);

import 'dart:convert';

class ModelsResponse {
  ModelsResponse({
    this.object,
    this.data,
  });

  String? object;
  List<Datum>? data;

  factory ModelsResponse.fromJson(String str) =>
      ModelsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelsResponse.fromMap(Map<String, dynamic> json) => ModelsResponse(
        object: json["object"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "object": object,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    this.id,
    this.object,
    this.created,
    this.ownedBy,
    this.permission,
    this.root,
    this.parent,
  });

  String? id;
  DatumObject? object;
  int? created;
  OwnedBy? ownedBy;
  List<Permission>? permission;
  String? root;
  dynamic parent;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        object: datumObjectValues.map[json["object"]],
        created: json["created"],
        ownedBy: ownedByValues.map[json["owned_by"]],
        permission: List<Permission>.from(
            json["permission"].map((x) => Permission.fromMap(x))),
        root: json["root"],
        parent: json["parent"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "object": datumObjectValues.reverse[object],
        "created": created,
        "owned_by": ownedByValues.reverse[ownedBy],
        "permission": List<dynamic>.from(permission!.map((x) => x.toMap())),
        "root": root,
        "parent": parent,
      };
}

enum DatumObject { MODEL }

final datumObjectValues = EnumValues({"model": DatumObject.MODEL});

enum OwnedBy { OPENAI, OPENAI_DEV, OPENAI_INTERNAL, SYSTEM }

final ownedByValues = EnumValues({
  "openai": OwnedBy.OPENAI,
  "openai-dev": OwnedBy.OPENAI_DEV,
  "openai-internal": OwnedBy.OPENAI_INTERNAL,
  "system": OwnedBy.SYSTEM
});

class Permission {
  Permission({
    this.id,
    this.object,
    this.created,
    this.allowCreateEngine,
    this.allowSampling,
    this.allowLogprobs,
    this.allowSearchIndices,
    this.allowView,
    this.allowFineTuning,
    this.organization,
    this.group,
    this.isBlocking,
  });

  String? id;
  PermissionObject? object;
  int? created;
  bool? allowCreateEngine;
  bool? allowSampling;
  bool? allowLogprobs;
  bool? allowSearchIndices;
  bool? allowView;
  bool? allowFineTuning;
  Organization? organization;
  dynamic group;
  bool? isBlocking;

  factory Permission.fromJson(String str) =>
      Permission.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permission.fromMap(Map<String, dynamic> json) => Permission(
        id: json["id"],
        object: permissionObjectValues.map[json["object"]],
        created: json["created"],
        allowCreateEngine: json["allow_create_engine"],
        allowSampling: json["allow_sampling"],
        allowLogprobs: json["allow_logprobs"],
        allowSearchIndices: json["allow_search_indices"],
        allowView: json["allow_view"],
        allowFineTuning: json["allow_fine_tuning"],
        organization: organizationValues.map[json["organization"]],
        group: json["group"],
        isBlocking: json["is_blocking"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "object": permissionObjectValues.reverse[object],
        "created": created,
        "allow_create_engine": allowCreateEngine,
        "allow_sampling": allowSampling,
        "allow_logprobs": allowLogprobs,
        "allow_search_indices": allowSearchIndices,
        "allow_view": allowView,
        "allow_fine_tuning": allowFineTuning,
        "organization": organizationValues.reverse[organization],
        "group": group,
        "is_blocking": isBlocking,
      };
}

enum PermissionObject { MODEL_PERMISSION }

final permissionObjectValues =
    EnumValues({"model_permission": PermissionObject.MODEL_PERMISSION});

enum Organization { EMPTY }

final organizationValues = EnumValues({"*": Organization.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

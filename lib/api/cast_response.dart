// To parse this JSON data, do
//
//     final castResponse = castResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CastResponse castResponseFromMap(String str) => CastResponse.fromMap(json.decode(str));

String castResponseToMap(CastResponse data) => json.encode(data.toMap());

class CastResponse {
  CastResponse({
    required this.cast,
    required this.crew,
    required this.id,
  });

  List<Cast> cast;
  List<dynamic> crew;
  int id;

  factory CastResponse.fromMap(Map<String, dynamic> json) => CastResponse(
    cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    crew: List<dynamic>.from(json["crew"].map((x) => x)),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "cast": List<dynamic>.from(cast.map((x) => x.toMap())),
    "crew": List<dynamic>.from(crew.map((x) => x)),
    "id": id,
  };
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.character,
    required this.creditId,
    required this.order,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  String character;
  String creditId;
  int order;

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"] ?? "unknown",
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"] == null ? "no Path" : json["profile_path"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
  );

  Map<String, dynamic> toMap() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": "Acting",
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath == null ? null : profilePath,
    "character": character,
    "credit_id": creditId,
    "order": order,
  };
}



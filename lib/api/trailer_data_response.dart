
import 'dart:convert';

TrailerData trailerDataFromJson(String str) => TrailerData.fromJson(json.decode(str));

String trailerDataToJson(TrailerData data) => json.encode(data.toJson());

class TrailerData {
  TrailerData({
    required this.id,
    required this.results,
  });

  int id;
  List<TrailerResult> results;

  factory TrailerData.fromJson(Map<String, dynamic> json) => TrailerData(
    id: json["id"],
    results: List<TrailerResult>.from(json["results"].map((x) => TrailerResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class TrailerResult {
  TrailerResult({
    required this.name,
    required this.key,
    required this.size,
    required this.official,
    required this.publishedAt,
    required this.id,
  });


  String name;
  String key;
  int size;
  bool official;
  DateTime publishedAt;
  String id;

  factory TrailerResult.fromJson(Map<String, dynamic> json) => TrailerResult(
    name: json["name"],
    key: json["key"],
    size: json["size"],
    official: json["official"],
    publishedAt: DateTime.parse(json["published_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
    "size": size,
    "official": official,
    "published_at": publishedAt.toIso8601String(),
    "id": id,
  };
}


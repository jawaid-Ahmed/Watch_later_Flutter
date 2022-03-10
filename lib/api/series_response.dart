
import 'dart:convert';

import 'package:practice/api/series.dart';

SeriesResponse seriesResponseFromJson(String str) => SeriesResponse.fromJson(json.decode(str));

String seriesResponseToJson(SeriesResponse data) => json.encode(data.toJson());

class SeriesResponse {
  SeriesResponse({
    required this.page,
    required this.series,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Series> series;
  int totalPages;
  int totalResults;

  factory SeriesResponse.fromJson(Map<String, dynamic> json) => SeriesResponse(
    page: json["page"],
    series: List<Series>.from(json["results"].map((x) => Series.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(series.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}



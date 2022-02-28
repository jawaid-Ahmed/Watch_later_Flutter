import 'package:hive/hive.dart';

part 'hivemovie.g.dart';

@HiveType(typeId: 0)
class HiveMovie extends HiveObject{

  @HiveField(0)
  late bool adult;

  @HiveField(1)
  late int id;

  @HiveField(2)
  late String originalLanguage;

  @HiveField(3)
  late String overview;

  @HiveField(4)
  late String posterPath;

  @HiveField(5)
  late String releaseDate;

  @HiveField(6)
  late String title;

  @HiveField(7)
  late double voteAverage;

  @HiveField(8)
  late int voteCount;


}
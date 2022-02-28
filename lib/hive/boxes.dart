import 'package:hive/hive.dart';
import 'package:practice/hive/hivemovie.dart';

class Boxes{

  static Box<HiveMovie> getHiveMovies() =>
      Hive.box<HiveMovie>('hivemovies');
}
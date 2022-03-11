import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/api/series.dart';
import 'package:practice/api/trailer_data_response.dart';
import 'package:practice/hive/hivemovie.dart';
import 'package:practice/screens/video_player_screen.dart';
import 'package:practice/widgets/casts/casts_series_list.dart';
import 'package:practice/widgets/recommeds/recommend_list.dart';
import 'package:http/http.dart' as http;
import 'package:practice/widgets/recommeds/recommend_list_series.dart';

import '../hive/boxes.dart';

class SeriesDetailsScreen extends StatefulWidget {
  Series drama;

  SeriesDetailsScreen({Key? key, required this.drama}) : super(key: key);

  @override
  _SeriesDetailsScreenState createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> {
  //final response = await http.get(Uri.parse(ApiService.BASE_URL+'${widget.movie}'+ApiService.GET_TRAILER+ApiService.API_KEY));

  genersFromId(List<int> ids) {
    Map<int, String> moviesGeners = {
      28: 'Action',
      12: 'Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      14: 'Fantasy',
      36: 'History',
      27: 'Horror',
      10402: 'Music',
      9648: 'Mystery',
      10749: 'Romance',
      878: 'Science Fiction',
      10770: 'TV Movie',
      53: 'Thriller',
      10752: 'War',
      37: 'Western',
    };

    String value = '';
    for (final mapEntry in moviesGeners.entries) {
      for (int i = 0; i < ids.length; i++) {
        if (mapEntry.key == ids[i]) {
          value += mapEntry.value + ",";
        }
      }
    }

    return value;
  }

  bool isLoading = false;
  bool trailerLoading = false;
  bool isFavourite = false;
  late Future<TrailerData> futureData;
  String trailerKey = '';

  @override
  void initState() {
    super.initState();

    setState(() {

    });
    openBox();

    createFavourite(
      widget.drama.name,
      widget.drama.firstAirDate.toString(),
      widget.drama.originalLanguage.toString(),
      widget.drama.id,
      false,
      widget.drama.posterPath,
      widget.drama.overview,
      widget.drama.voteAverage,
      widget.drama.voteCount,
    );

    loadTrailer();
  }

  Future openBox() async {
    await Hive.openBox<HiveMovie>('hivemovies');
  }

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  Future<void> loadTrailer() async {
    setState(() {
      trailerLoading = true;
    });
    final response = await http.get(Uri.parse(ApiService.BASE_URL_SERIES +
        widget.drama.id.toString() +
        ApiService.GET_TRAILER +
        ApiService.API_KEY));
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);
      TrailerData movie = TrailerData.fromJson(jsonResp);

      for (var data in movie.results) {
        if (data.official) {
          trailerKey = movie.results.first.key;
        }
      }

      if (trailerKey != '') {
        setState(() {
          trailerLoading = false;
        });
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.drama,
                  child: Image(
                    image: NetworkImage(
                        ApiService.IMAGE_URLBIG + widget.drama.posterPath),
                    fit: BoxFit.cover,
                    height: size.height * 0.85,
                    width: size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 35.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 32,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: IconButton(
                          onPressed: () {
                            if (isFavourite) {
                              deleteFromFavourites(
                                widget.drama.name,
                                widget.drama.firstAirDate.toString(),
                                widget.drama.originalLanguage.toString(),
                                widget.drama.id,
                                false,
                                widget.drama.posterPath,
                                widget.drama.overview,
                                widget.drama.voteAverage,
                                widget.drama.voteCount,
                              );
                            } else {
                              addHiveMovie(
                                  widget.drama.name,
                                  widget.drama.firstAirDate.toString(),
                                  widget.drama.originalLanguage.toString(),
                                  widget.drama.id,
                                  false,
                                  widget.drama.posterPath,
                                  widget.drama.overview,
                                  widget.drama.voteAverage,
                                  widget.drama.voteCount,
                                  context);

                              setState(() {
                                isFavourite = true;
                              });
                            }
                          },
                          icon: isFavourite
                              ? const Icon(
                                  Icons.favorite,
                                  size: 32,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                  size: 32,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0.0,
                  bottom: 110,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => VideoPlayerScreen(
                                      trailer_key: trailerKey,
                                    )));
                      },
                      icon: trailerLoading
                          ? const CircularProgressIndicator()
                          : const Icon(
                              Icons.play_circle_fill_outlined,
                              size: 38,
                            ),
                      label: const Text(
                        'Watch Trailer',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 15,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.drama.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Text(
              '[${genersFromId(widget.drama.genreIds)}]',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.grey.shade500),
            ),


            CastSeries(movieId: widget.drama.id),

            SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Storyline:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 8),
                    child: Text(
                      widget.drama.overview,
                      style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Adult :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0, top: 5),
                        child: Text(
                          'Language :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 8),
                        child: Text(
                          widget.drama.originalLanguage,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0, top: 5),
                        child: Text(
                          'Release Date :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 5),
                        child: Text(
                          widget.drama.firstAirDate.toString().split(' ').first,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0, top: 5),
                        child: Text(
                          'Ratings :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 5),
                        child: Text(
                          widget.drama.voteAverage.toString() +
                              ' total Votes: ' +
                              widget.drama.voteCount.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  RecommendSeries(movieId: widget.drama.id),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool movieExist(HiveMovie movie) {
    bool exist = false;

    final box = Boxes.getHiveMovies();
    for (HiveMovie movi in box.values) {
      if (movi.id == movie.id) {
        exist = true;
      }
    }

    return exist;
  }

  Future deleteFromFavourites(
    String title,
    String releaseDate,
    String lang,
    int id,
    bool isAdult,
    String imageUrl,
    String overView,
    double voteAvg,
    int voteCOunt,
  ) async {
    final movie = HiveMovie()
      ..id = id
      ..title = title
      ..releaseDate = releaseDate
      ..adult = isAdult
      ..posterPath = imageUrl
      ..overview = overView
      ..voteCount = voteCOunt
      ..voteAverage = voteAvg
      ..originalLanguage = lang;

    final box = Boxes.getHiveMovies();
    for (HiveMovie movi in box.values) {
      if (movi.id == movie.id) {
        movi.delete();
        setState(() {
          isFavourite = false;
        });
      }
    }
  }

  Future addHiveMovie(
      String title,
      String releaseDate,
      String lang,
      int id,
      bool isAdult,
      String imageUrl,
      String overView,
      double voteAvg,
      int voteCOunt,
      BuildContext context) async {
    final movie = HiveMovie()
      ..id = id
      ..title = title
      ..releaseDate = releaseDate
      ..adult = isAdult
      ..posterPath = imageUrl
      ..overview = overView
      ..voteCount = voteCOunt
      ..voteAverage = voteAvg
      ..originalLanguage = lang;

    final box = Boxes.getHiveMovies();

    if (!movieExist(movie)) {
      box.add(movie);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Movie Added Successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Movie Already Favourite")));
    }
  }

  void deleteHiveMovie(HiveMovie hiveMovie) {
    hiveMovie.delete();
  }

  createFavourite(
    String title,
    String releaseDate,
    String lang,
    int id,
    bool isAdult,
    String imageUrl,
    String overView,
    double voteAvg,
    int voteCOunt,
  ) async {
    await Hive.openBox<HiveMovie>('hivemovies');
    final movie = HiveMovie()
      ..id = id
      ..title = title
      ..releaseDate = releaseDate
      ..adult = isAdult
      ..posterPath = imageUrl
      ..overview = overView
      ..voteCount = voteCOunt
      ..voteAverage = voteAvg
      ..originalLanguage = lang;

    if (!movieExist(movie)) {
      setState(() {
        isFavourite = false;
      });
    } else {
      setState(() {
        isFavourite = true;
        //hiveGlobalMovie=movie;
      });
    }
  }
}

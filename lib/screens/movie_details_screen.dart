import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/api/trailer_data_response.dart';
import 'package:practice/hive/hivemovie.dart';
import 'package:practice/screens/video_player_screen.dart';
import 'package:practice/widgets/casts/casts_list.dart';
import 'package:practice/widgets/genres_containers.dart';
import 'package:practice/widgets/recommeds/recommend_list.dart';
import 'package:http/http.dart' as http;

import '../hive/boxes.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Result movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
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
      878: 'Sci-Fi',
      10770: 'TV Movie',
      53: 'Thriller',
      10752: 'War',
      37: 'Western',
    };

    List<String> value =[];
    for (final mapEntry in moviesGeners.entries) {
      for (int i = 0; i < ids.length; i++) {
        if (mapEntry.key == ids[i]) {
          value.add(mapEntry.value);
        }
      }
    }

    return value;
  }

  bool isLoading = false;
  bool trailerLoading = false;
  bool isFavourite = false;
  bool movieRated=true;

  late Future<TrailerData> futureData;
  String trailerKey = '';

  List<String> genreIdsList=[];

  @override
  void initState() {
    super.initState();



    openBox();

    createFavourite(
      widget.movie.title,
      widget.movie.releaseDate.toString(),
      widget.movie.originalLanguage.toString(),
      widget.movie.id,
      widget.movie.adult,
      widget.movie.posterPath,
      widget.movie.overview,
      widget.movie.voteAverage,
      widget.movie.voteCount,
    );


    genreIdsList=genersFromId(widget.movie.genreIds);

    loadTrailer();
  }

  Future openBox()async {
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
    final response = await http.get(Uri.parse(

        ApiService.BASE_URL+widget.movie.id.toString()+ApiService.GET_TRAILER+ApiService.API_KEY));
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);
      TrailerData movie = TrailerData.fromJson(jsonResp);

      for (var data in movie.results) {
        if (data.official) {
          trailerKey = data.key;
        }
      }

      if(trailerKey==''){
        trailerKey=movie.results.first.key;
        setState(() {
          trailerLoading = false;
        });
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
                Container(
                  height: size.height * 0.85,
                  width: size.width,
                  color: Colors.transparent,
                ),
                Hero(
                  tag: widget.movie,
                  child: Image(
                    image: NetworkImage(
                        ApiService.IMAGE_URLBIG + widget.movie.posterPath),
                    fit: BoxFit.cover,
                    height: size.height * 0.75,
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
                            size: 26,
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
                                widget.movie.title,
                                widget.movie.releaseDate.toString(),
                                widget.movie.originalLanguage.toString(),
                                widget.movie.id,
                                widget.movie.adult,
                                widget.movie.posterPath,
                                widget.movie.overview,
                                widget.movie.voteAverage,
                                widget.movie.voteCount,
                              );
                            } else {
                              addHiveMovie(
                                  widget.movie.title,
                                  widget.movie.releaseDate.toString(),
                                  widget.movie.originalLanguage.toString(),
                                  widget.movie.id,
                                  widget.movie.adult,
                                  widget.movie.posterPath,
                                  widget.movie.overview,
                                  widget.movie.voteAverage,
                                  widget.movie.voteCount,
                                  context);

                              setState(() {
                                isFavourite = true;
                              });
                            }
                          },
                          icon: isFavourite
                              ? const Icon(
                                  Icons.favorite,
                                  size: 26,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                  size: 26,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0.0,
                  bottom: 120,
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
                    left: 15,
                    bottom: 35,
                    right: 15,
                    child: Center(child: GenersContainersWidget(genreIdsList: genreIdsList,)))

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 5),
              child: Text(
                widget.movie.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),

            Container(
              width: size.width,
              color: Colors.transparent,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 15,
                      ),
                      onRatingUpdate: (rating) async {
                        await rateAMovie(rating);
                      },
                    ),
                    !movieRated ? const CircularProgressIndicator() : const SizedBox(),
                  ],
                )
              ),
            ),

            CastMovies(movieId: widget.movie.id),

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
                      widget.movie.overview,
                      style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Adult :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 8),
                        child: Text(
                          widget.movie.adult.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: widget.movie.adult
                                  ? Colors.red
                                  : Colors.green),
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
                          widget.movie.originalLanguage,
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
                          widget.movie.releaseDate.toString().split(' ').first,
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
                          widget.movie.voteAverage.toString() +
                              ' total Votes: ' +
                              widget.movie.voteCount.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Recommend(movieId: widget.movie.id),
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
        exist=true;
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

      )async{

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
          isFavourite=false;
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
        isFavourite=false;
      });
    } else {
      setState(() {
        isFavourite=true;
        //hiveGlobalMovie=movie;
      });
    }
  }

  rateAMovie(double rating) async {
    setState(() {
      movieRated=false;
    });

    rating = rating * 2;

    Uri uri = Uri.parse(ApiService.SESSIONID_AP+ApiService.API_KEY);

    var resp = await http.post(
      uri,
    );

    print('............................tryhing Request.......................');
    if(resp.statusCode==200){

      print('StatusCode: '+resp.statusCode.toString());

      var jsonResp = jsonDecode(resp.body);
      String sessionId=jsonResp['guest_session_id'];

      print(sessionId);


      String url=ApiService.BASE_URL+widget.movie.id.toString()+ApiService.RATING+ApiService.API_KEY+ApiService.SESSIONID+sessionId;
      Uri uri = Uri.parse(url);

      var body = {"value": rating.toString()};
      var res = await http.post(
        uri,
        body: body,
      );

      if(jsonDecode(res.body)['success']){
        setState(() {
          movieRated=true;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Movie Rated Successfully")));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ratings Couldn't be Saved")));
      }

    }



  }
}

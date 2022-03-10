import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/widgets/has_error_widget.dart';
import 'package:practice/widgets/movie_placeholder_widget.dart';
import 'package:http/http.dart' as http;

import '../single_movie_item_widget.dart';
class HorrorMoviesTabWidget extends StatefulWidget {
  String genere;
  HorrorMoviesTabWidget({Key? key,required this.genere}) : super(key: key);

  @override
  _HorrorMoviesTabWidgetState createState() => _HorrorMoviesTabWidgetState();
}

class _HorrorMoviesTabWidgetState extends State<HorrorMoviesTabWidget> {

  bool isLoading=false;
  late Future<Movie> futureData;


  @override
  void initState() {
    super.initState();

    futureData=loadNowPlaying();
  }

  Future<Movie> loadNowPlaying()async {
    setState(() {
      isLoading=true;
    });
    final response = await http.get(Uri.parse(ApiService.BASE_URL+ApiService.INTHEATERS+ApiService.API_KEY+widget.genere));

    if(response.statusCode==200) {

      var jsonResp=jsonDecode(response.body);
      Movie movie=Movie.fromJson(jsonResp);

      setState(() {
        isLoading=true;
      });
      return movie;
      //return res.map((data) => Result.fromJson(data)).toList();

    }else{
      return jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Wrong Response")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 500,
          child: FutureBuilder <Movie>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Movie? data = snapshot.data;
                return
                  GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1 / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 2),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(6),
                      itemCount: data!.results.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        Result movie=data.results[index];

                        return MovieItemWidget(movie: movie);
                      }
                  );
              } else if (snapshot.hasError) {
                return const HasErrorWidget();
              }
              // By default show a loading spinner.
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {

                    return const MoviePlaceHolder();
                  }
              );
            },
          ),
        ),
      ],
    );
  }
}



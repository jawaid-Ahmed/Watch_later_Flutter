import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/widgets/has_error_widget.dart';
import 'package:practice/widgets/movie_placeholder_widget.dart';
import 'package:practice/widgets/nowplaying/single_movie_item_widget.dart';


class Recommend extends StatefulWidget {
  int movieId;
  Recommend({Key? key,required this.movieId}) : super(key: key);

  @override
  State<Recommend> createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {

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
    final response = await http.get(Uri.parse(ApiService.BASE_URL+widget.movieId.toString()+ApiService.GET_SIMILAR+ApiService.API_KEY));

    if(response.statusCode==200) {

      var jsonResp=jsonDecode(response.body);
      Movie movie=Movie.fromJson(jsonResp);

      setState(() {
        isLoading=true;
      });
      return movie;


    }else{

      return jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0,top: 35,bottom: 15),
          child: Text('Recommends'
            ,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,),),
        ),
        SizedBox(
          height: 300,
          child: FutureBuilder <Movie>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Movie? data = snapshot.data;
                return
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                      itemCount: data!.results.length,
                      scrollDirection: Axis.horizontal,
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

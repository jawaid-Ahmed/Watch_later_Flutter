import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/api/api.dart';
import 'package:practice/api/cast_response.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/widgets/casts/single_cast_item_widget.dart';
import 'package:practice/widgets/has_error_widget.dart';
import 'package:practice/widgets/movie_placeholder_widget.dart';
import 'package:practice/widgets/single_movie_item_widget.dart';


class CastMovies extends StatefulWidget {
  int movieId;
  CastMovies({Key? key,required this.movieId}) : super(key: key);

  @override
  State<CastMovies> createState() => _CastMoviesState();
}

class _CastMoviesState extends State<CastMovies> {

  bool isLoading=false;
  late Future<CastResponse> futureData;

  @override
  void initState() {
    super.initState();
    futureData=loadNowPlaying();
  }

  Future<CastResponse> loadNowPlaying()async {
    setState(() {
      isLoading=true;
    });
    final response = await http.get(Uri.parse(ApiService.BASE_URL+widget.movieId.toString()+ApiService.MOVIE_CAST+ApiService.API_KEY));

    if(response.statusCode==200) {

      var jsonResp=jsonDecode(response.body);
      CastResponse movie=CastResponse.fromMap(jsonResp);

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
          child: Text('Star Cast'
            ,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,),),
        ),
        SizedBox(
          height: 100,
          child: FutureBuilder <CastResponse>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                CastResponse? data = snapshot.data;
                return
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                      itemCount: data!.cast.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        Cast actor=data.cast[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CastItemWidget(actor: actor),
                        );
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/api/series.dart';
import 'package:practice/api/series_response.dart';
import 'package:practice/widgets/has_error_widget.dart';
import 'package:practice/widgets/movie_placeholder_widget.dart';
import 'package:practice/widgets/single_movie_item_widget.dart';
import 'package:practice/widgets/single_serie_item_widget.dart';


class RecommendSeries extends StatefulWidget {
  int movieId;
  RecommendSeries({Key? key,required this.movieId}) : super(key: key);

  @override
  State<RecommendSeries> createState() => _RecommendSeriesState();
}

class _RecommendSeriesState extends State<RecommendSeries> {

  bool isLoading=false;
  late Future<SeriesResponse> futureData;

  @override
  void initState() {
    super.initState();
    futureData=loadNowPlaying();
  }

  Future<SeriesResponse> loadNowPlaying()async {
    setState(() {
      isLoading=true;
    });
    final response = await http.get(Uri.parse(ApiService.BASE_URL_SERIES+widget.movieId.toString()+ApiService.GET_SIMILAR+ApiService.API_KEY));

    if(response.statusCode==200) {

      var jsonResp=jsonDecode(response.body);



      SeriesResponse movie=SeriesResponse.fromJson(jsonResp);

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
          child: FutureBuilder <SeriesResponse>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                SeriesResponse? data = snapshot.data;
                return
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                      itemCount: data!.series.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        Series movie=data.series[index];

                        return SerieItemWidget(movie: movie);
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

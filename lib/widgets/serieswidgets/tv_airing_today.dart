import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/api/api.dart';
import 'package:practice/api/series.dart';
import 'package:practice/api/series_response.dart';
import 'package:practice/widgets/has_error_widget.dart';
import 'package:practice/widgets/movie_placeholder_widget.dart';
import 'package:practice/widgets/single_serie_item_widget.dart';


class AiringTodaySeries extends StatefulWidget {
  String baseUrl;
  AiringTodaySeries({Key? key,required this.baseUrl}) : super(key: key);

  @override
  State<AiringTodaySeries> createState() => _AiringTodaySeriesState();
}

class _AiringTodaySeriesState extends State<AiringTodaySeries> {

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
    final response = await http.get(Uri.parse(widget.baseUrl+ApiService.AIRINGTODAYSERIES+ApiService.API_KEY));

    if(response.statusCode==200) {



      var jsonResp=jsonDecode(response.body);
      SeriesResponse serie=SeriesResponse.fromJson(jsonResp);


      setState(() {
        isLoading=true;
      });
      return serie;
      //return res.map((data) => Result.fromJson(data)).toList();

    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Wrong Response")));
      return jsonDecode(response.body);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('Airing Today',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
        ),
        SizedBox(
          height: 300,
          child: FutureBuilder <SeriesResponse>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                SeriesResponse? data = snapshot.data ;
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

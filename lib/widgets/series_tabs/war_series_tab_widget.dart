import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/api/series.dart';
import 'package:practice/api/series_response.dart';
import 'package:practice/widgets/has_error_widget.dart';
import 'package:practice/widgets/movie_placeholder_widget.dart';
import 'package:http/http.dart' as http;
import 'package:practice/widgets/single_serie_item_widget.dart';

import '../single_movie_item_widget.dart';
class WarSeriesTabWidget extends StatefulWidget {
  String genere;
  WarSeriesTabWidget({Key? key,required this.genere,}) : super(key: key);

  @override
  _WarSeriesTabWidgetState createState() => _WarSeriesTabWidgetState();
}

class _WarSeriesTabWidgetState extends State<WarSeriesTabWidget> {

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
    final response = await http.get(Uri.parse(ApiService.BASE_URL_SERIESDISCOVER+ApiService.API_KEY+widget.genere));


    if(response.statusCode==200) {

      var jsonResp=jsonDecode(response.body);


      SeriesResponse movie=SeriesResponse.fromJson(jsonResp);
      print('.........................war.....................');
      print(jsonResp.toString());

      setState(() {
        isLoading=true;
      });
      return movie;


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
        SizedBox(
          height: 500,
          child: FutureBuilder <SeriesResponse>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                SeriesResponse? data = snapshot.data;
                return
                  GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1 / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 2),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(6),
                      itemCount: data!.series.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        Series movie=data.series[index];

                        return SerieItemWidget(movie: movie);
                      }
                  );
              } else if (snapshot.hasError) {
                return
                    const HasErrorWidget();
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



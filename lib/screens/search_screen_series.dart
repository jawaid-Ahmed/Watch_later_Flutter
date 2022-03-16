import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/api/series.dart';
import 'package:practice/api/series_response.dart';
import 'package:practice/widgets/has_error_widget.dart';
import 'package:http/http.dart' as http;
import 'package:practice/widgets/movie_placeholder_widget.dart';
import 'package:practice/widgets/single_movie_item_widget.dart';
import 'package:practice/widgets/single_serie_item_widget.dart';
class SearchScreenSeries extends StatefulWidget {
  const SearchScreenSeries({Key? key}) : super(key: key);

  @override
  State<SearchScreenSeries> createState() => _SearchScreenSeriesState();
}

class _SearchScreenSeriesState extends State<SearchScreenSeries> {


  //late Future<Movie> futureData;
  late TextEditingController _inputController;
  var futureData;

  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();


  }


  Future<SeriesResponse> searchSeries(String query)async {
    setState(() {
      isLoading=true;
    });
    final response = await http.get(Uri.parse(ApiService.BASE_URL_MOVIES_SEARCH+ApiService.API_KEY+query));

    if(response.statusCode==200) {

      var jsonResp=jsonDecode(response.body);


      ///some of json fields can be null so we use below logic for that.

      var movies=jsonResp["results"];

      SeriesResponse movie=SeriesResponse(page: jsonResp["page"], series: [], totalPages: jsonResp["total_pages"], totalResults: jsonResp["totalResults"]);
        for(int i=0; i<8; i++) {
          Series result = Series.fromJson(movies[i]);
          movie.series.add(result);
        }

      setState(() {

        isLoading=true;
      });
      return movie;

    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No Series Found")));
      return jsonDecode(response.body);

    }
  }
  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CupertinoSearchTextField(
                      placeholder: "search series ",
                      controller: _inputController,
                      onSubmitted: (val){
                        if(_inputController.text.length > 1){
                          setState(() {
                            this.futureData=null;
                          });
                          Future<SeriesResponse> futureData=searchSeries("&query="+val);
                          setState(() {
                            this.futureData=futureData;
                          });
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Insert Series Name")));
                        }
                      },
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                        const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {

                      if(_inputController.text.length > 1 ) {
                        setState(() {
                          this.futureData = null;
                        });
                        Future<SeriesResponse> futureData = searchSeries(
                            "&query=" + _inputController.text);
                        setState(() {
                          this.futureData = futureData;
                        });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Insert Series Name")));
                      }

                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
          futureData !=null ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
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
          ) : SizedBox(),
        ],),
      )
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/widgets/movie_placeholder_widget.dart';
import 'package:practice/widgets/nowplaying/single_movie_item_widget.dart';


class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {

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
    final response = await http.get(Uri.parse(ApiService.BASE_URL+ApiService.POPULAR+ApiService.API_KEY));

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('Popular',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
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
                return Text("${snapshot.error}");
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/widgets/nowplaying/single_movie_item_widget.dart';


class PlayingNow extends StatefulWidget {
  const PlayingNow({Key? key}) : super(key: key);

  @override
  State<PlayingNow> createState() => _PlayingNowState();
}

class _PlayingNowState extends State<PlayingNow> {

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
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=b8cdc8a029caa73a47ab09762ce5c157'));

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
          child: Text('Now Playing',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
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
              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/widgets/nowplaying/playing_now_list.dart';
import 'package:practice/widgets/popular/popular_list.dart';
import 'package:practice/widgets/top_rated/toprated_list.dart';
class AllMoviesTabWidget extends StatefulWidget {
  const AllMoviesTabWidget({Key? key}) : super(key: key);

  @override
  _AllMoviesTabWidgetState createState() => _AllMoviesTabWidgetState();
}

class _AllMoviesTabWidgetState extends State<AllMoviesTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlayingNow(baseUrl: ApiService.BASE_URL),
        Popular(baseUrl: ApiService.BASE_URL),
        TopRated(baseUrl: ApiService.BASE_URL)
      ],
    );
  }
}

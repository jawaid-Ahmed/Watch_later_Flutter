import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/widgets/serieswidgets/on_air_series.dart';
import 'package:practice/widgets/nowplaying/playing_now_list.dart';
import 'package:practice/widgets/popular/popular_list.dart';
import 'package:practice/widgets/serieswidgets/popular_series.dart';
import 'package:practice/widgets/serieswidgets/top_rated_series.dart';
import 'package:practice/widgets/serieswidgets/tv_airing_today.dart';
import 'package:practice/widgets/top_rated/toprated_list.dart';
class AllSeriesTabWidget extends StatefulWidget {
  const AllSeriesTabWidget({Key? key}) : super(key: key);

  @override
  _AllSeriesTabWidgetState createState() => _AllSeriesTabWidgetState();
}

class _AllSeriesTabWidgetState extends State<AllSeriesTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AiringTodaySeries(baseUrl: ApiService.BASE_URL_SERIES),
        OnAirSeries(baseUrl: ApiService.BASE_URL_SERIES),
        PopularSeries(baseUrl: ApiService.BASE_URL_SERIES),
        TopRatedSeries(baseUrl: ApiService.BASE_URL_SERIES),


      ],
    );
  }
}

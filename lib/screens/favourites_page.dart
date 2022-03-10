import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:practice/hive/boxes.dart';
import 'package:practice/hive/hivemovie.dart';
import 'package:practice/widgets/hive_movie_widget.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {

  @override
  void initState() {
    openBox();
    super.initState();
  }

  Future openBox()async {
    await Hive.openBox<HiveMovie>('hivemovies');
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: const Text('Favourites',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ),
      body:ValueListenableBuilder<Box<HiveMovie>>(
        valueListenable:Boxes.getHiveMovies().listenable(),
        builder: (context,box,_){
          final movies = box.values.toList().cast<HiveMovie>();
          return buildMoviesGrid(movies);
        },
      ) ,
    );
  }
Widget buildMoviesGrid(List<HiveMovie> movies) {

  if(movies.isEmpty){
    return const Center(child: Text('No Movies Yet'),);
  }else{
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: movies.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        final movie = movies[index];
        return HiveMovieWidget(movie: movie);
      }, gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 2),
    );
  }

}

}


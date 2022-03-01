import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/hive/hivemovie.dart';
import 'package:practice/screens/movie_details_screen.dart';

class HiveMovieWidget extends StatelessWidget {
  HiveMovie movie;

  HiveMovieWidget({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: (){
        Result result=Result(adult: movie.adult,
            backdropPath: movie.posterPath,
            genreIds: [],
            id: movie.id,
            originalLanguage: movie.originalLanguage,
            originalTitle: movie.title,
            overview: movie.overview,
            popularity: 0.0,
            posterPath: movie.posterPath,
            releaseDate: DateTime.parse(movie.releaseDate),
            title: movie.title,
            video: false,
            voteAverage: movie.voteAverage,
            voteCount: movie.voteCount
        );

        Navigator.push(context, MaterialPageRoute(builder: (_)=> MovieDetailsScreen(movie: result)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child:
              CachedNetworkImage(
                imageUrl: ApiService.IMAGE_URL+movie.posterPath,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context,val){
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child:
                        const Image(image:  AssetImage('assets/images/icon.png'),)
                      ),
                      Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(onPressed: (){}, icon: const Icon(Icons.play_circle_fill_outlined,size: 32,))),

                      Positioned(
                          top: 4,
                          right: 4,
                          child: IconButton(onPressed: (){
                            deleteHiveMovie(movie);
                          }, icon: const Icon(Icons.clear,size: 20,)))
                    ],
                  );
                },
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned(
                top: 10,
                left: 10,
                child: IconButton(onPressed: (){}, icon: const Icon(Icons.play_circle_fill_outlined,size: 32,))),

            Positioned(
                top: 4,
                right: 4,
                child: IconButton(onPressed: (){
                  deleteHiveMovie(movie);
                }, icon: const Icon(Icons.clear,size: 20,)))
          ],
        ),
      ),
    );
  }

  void deleteHiveMovie(HiveMovie hiveMovie) {
    hiveMovie.delete();
    //setState(() => transactions.remove(transaction));
  }
}

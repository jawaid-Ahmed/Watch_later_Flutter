import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_result.dart';

class MovieItemWidget extends StatelessWidget {
  Result movie;

  MovieItemWidget({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(image: NetworkImage(ApiService.IMAGE_URL+movie.posterPath),fit: BoxFit.fill,width: double.infinity,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.play_circle_fill_outlined,size: 32,))
          // Positioned(
          //   left: 5,
          //   bottom: 30,
          //   child: Column(children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(movie.title,style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w600),),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(movie.releaseDate.toString().split(' ').first,style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w600),),
          //     )
          //   ],),
          // )
        ],
      ),
    );
  }
}

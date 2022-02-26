import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/screens/movie_details_screen.dart';

class MovieItemWidget extends StatelessWidget {
  Result movie;

  MovieItemWidget({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> MovieDetailsScreen( movie: movie,)));},
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
                child: Image(image: NetworkImage(ApiService.IMAGE_URL+movie.posterPath),fit: BoxFit.fill,width: double.infinity,)),
            Positioned(
                top: 15,
                left: 15,
                child: IconButton(onPressed: (){}, icon: const Icon(Icons.play_circle_fill_outlined,size: 32,)))
          ],
        ),
      ),
    );
  }
}

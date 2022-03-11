import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/series.dart';
import 'package:practice/screens/movie_details_screen.dart';
import 'package:practice/screens/series_details_screen.dart';

class SerieItemWidget extends StatelessWidget {
  Series movie;

  SerieItemWidget({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
          PageRouteBuilder(
              transitionDuration: const Duration(seconds: 2),
              pageBuilder: (_, __, ___) => SeriesDetailsScreen( drama: movie,))

     );
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
                Hero(
                  tag: movie,
                  child: CachedNetworkImage(
                    imageUrl: ApiService.IMAGE_URL+movie.posterPath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context,val){
                      return const Center(child:Image(image:  AssetImage('assets/images/icon.png'),));
                    },
                    errorWidget: (context, url, error) =>const Center(child:  Icon(Icons.error)),
                  ),
                ),
            ),

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

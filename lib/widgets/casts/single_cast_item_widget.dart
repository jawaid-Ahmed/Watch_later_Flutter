import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/cast_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/screens/movie_details_screen.dart';

class CastItemWidget extends StatelessWidget {
  Cast actor;

  CastItemWidget({Key? key,required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //Navigator.push(context,
          // PageRouteBuilder(
          //     transitionDuration: const Duration(seconds: 2),
          //     pageBuilder: (_, __, ___) => MovieDetailsScreen( actor: actor,))

      //);
        },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child:
        Hero(
          tag: actor,
          child: CachedNetworkImage(
            imageUrl: ApiService.IMAGE_URL+actor.profilePath,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
            placeholder: (context,val){
              return const Center(child:Image(image:  AssetImage('assets/images/icon.png'),));
            },
            errorWidget: (context, url, error) => Container(height: 80,width: 80,color: Colors.black,child: const Icon(Icons.error)),
          ),
        ),
      ),
    );
  }
}

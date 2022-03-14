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
      onTap: () async {
        await showDialog(
            context: context,
            builder: (_) => ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: imageDialog(actor,context))
        );
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

Widget imageDialog(Cast actor, BuildContext context) {
  return Dialog(
    // backgroundColor: Colors.transparent,
    // elevation: 0,
    child: ClipRRect(
        borderRadius: BorderRadius.circular(35),

        child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
       
        child: Stack(
          children: [
            Hero(
              tag: actor,
              child: Image.network(
                ApiService.IMAGE_URL+actor.profilePath,
                fit: BoxFit.cover,
            ),
            ),

            Positioned(
              right: 15,
                top: 15,
                child:IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.redAccent,
                ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child:Text(actor.originalName,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)
            ),
          ],
        )
      ),
    ),
  );}



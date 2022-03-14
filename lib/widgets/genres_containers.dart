import 'package:flutter/material.dart';
class GenersContainersWidget extends StatelessWidget {
  List<String> genreIdsList;
  GenersContainersWidget({Key? key,required this.genreIdsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
          height: 70,
          width: MediaQuery.of(context).size.width,
          child:ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: genreIdsList.length,
              itemBuilder: (context, index){
                String genre=genreIdsList[index];
                return Container(
                    height: 60,
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      child: Text(genre,style: const TextStyle(fontWeight: FontWeight.w600)),
                );
              })

      ),
    );
  }
}

import 'package:flutter/material.dart';
class GenersContainersWidget extends StatelessWidget {
  final List<String> genreIdsList;
  const GenersContainersWidget({Key? key,required this.genreIdsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.6),
          ),
          child:ListView.builder(
              padding: const EdgeInsets.all(2),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: genreIdsList.length,
              itemBuilder: (context, index){
                String genre=genreIdsList[index];
                return Container(
                    height: 50,
                    width: 80,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.8),
                      ),
                      child: Center(child: Text(genre)),
                );
              })

      ),
    );
  }
}

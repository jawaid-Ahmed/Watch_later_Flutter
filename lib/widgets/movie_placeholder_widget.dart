import 'package:flutter/material.dart';

class MoviePlaceHolder extends StatelessWidget {
  const MoviePlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade500.withOpacity(0.2),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 15,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                  size: 32,
                )),
          ),
          const Center(child: CircularProgressIndicator(),),
        ],
      ),
    );
  }
}

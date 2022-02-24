import 'package:flutter/material.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourites",style: TextStyle(fontWeight: FontWeight.w500,
          color:Theme.of(context).primaryColor
      ),),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ),
      body:const SizedBox() ,
    );
  }
}


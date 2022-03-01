import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/widgets/nowplaying/playing_now_list.dart';
import 'package:practice/widgets/nowplaying/single_movie_item_widget.dart';
import 'package:practice/widgets/popular/popular_list.dart';
import 'package:practice/widgets/top_rated/toprated_list.dart';
import 'package:http/http.dart' as http;
import 'package:search_page/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  late List<Result> moviesList;
  late Future<Movie> futureData;

  bool isLoading=false;


  @override
  void initState(){
    super.initState();
    futureData=loadAllMovies();
  }

  Future<Movie> loadAllMovies()async {
    setState(() {
      isLoading=true;
    });
    final response = await http.get(Uri.parse(ApiService.BASE_URL+ApiService.INTHEATERS+ApiService.API_KEY));

    if(response.statusCode==200) {

      var jsonResp=jsonDecode(response.body);
      Movie movie=Movie.fromJson(jsonResp);
      List<Result> moviesList=movie.results;

      setState(() {
        this.moviesList=moviesList;
        isLoading=true;
      });
      return movie;
      //return res.map((data) => Result.fromJson(data)).toList();

    }else{
      return jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Wrong Response")));
    }
  }


  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Theme.of(context).primaryColor,
              )),
          PopupMenuButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).primaryColor,
            ), //don't specify icon if you want 3 dot menu
            color: Theme.of(context).scaffoldBackgroundColor,
            itemBuilder: (context) => const [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Preferences"),
              ),
              PopupMenuItem<int>(
                value: 0,
                child: Text("Setting"),
              ),
              PopupMenuItem<int>(
                value: 0,
                child: Text("Logout"),
              ),
            ],
            onSelected: (item) => {print(item)},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CupertinoSearchTextField(
                        placeholder: "search movies series ",
                        controller: _inputController,
                        onTap: () {
                          //createDialoge();
                        },
                        onChanged: (value) async {
                          if (value.isNotEmpty) {
                            showSearch(
                              context: context,
                              delegate: SearchPage<Result>(
                                items: moviesList,
                                searchLabel: 'Search movies',
                                suggestion: const Center(
                                  child: Text('Filter movies by name'),
                                ),
                                failure: const Center(
                                  child: Text('No movies found :('),
                                ),
                                filter: (movie) => [
                                  movie.title,
                                  movie.overview,
                                ],
                                builder: (movie) => MovieItemWidget(movie: movie),
                              ),
                            );
                          }
                        },
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            const PlayingNow(),
            const Popular(),
            const TopRated()
          ],
        ),
      ),
    );
  }

  void createDialoge() {
    showGeneralDialog(
      context: context,
      barrierColor: Theme.of(context).scaffoldBackgroundColor,
      // Background color
      barrierDismissible: false,
      barrierLabel: 'Search',
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Scaffold(body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CupertinoSearchTextField(
                        placeholder: "search movies series ",
                        onTap: () {
                          createDialoge();
                        },
                        onChanged: (value) async {
                          if (value.isNotEmpty) {}
                        },
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                          const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {Navigator.pop(context);},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: 15,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 400,
                        height: 50,
                        margin: const EdgeInsets.all(15),
                        color: Colors.purple,
                      );
                    }),
              ),
            ],
          ),
        ));
      },
    );
  }
}

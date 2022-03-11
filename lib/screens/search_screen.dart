import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/widgets/has_error_widget.dart';
import 'package:http/http.dart' as http;
import 'package:practice/widgets/movie_placeholder_widget.dart';
import 'package:practice/widgets/single_movie_item_widget.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  //late Future<Movie> futureData;
  late TextEditingController _inputController;
  var futureData;

  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();


  }

/*  showSearchPage() {
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
  }*/
  Future<Movie> loadAllMovies(String query)async {
    setState(() {
      isLoading=true;
    });
    final response = await http.get(Uri.parse(ApiService.BASE_URL_MOVIES_SEARCH+ApiService.API_KEY+query));

    if(response.statusCode==200) {

      var jsonResp=jsonDecode(response.body);



      Movie movie=Movie.fromJson(jsonResp);
      print('.......................search..................');
      print(jsonResp.toString());

      setState(() {

        isLoading=true;
      });
      return movie;

    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No Movies Found")));
      return jsonDecode(response.body);

    }
  }
  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
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
                      onSubmitted: (val){
                        setState(() {
                          this.futureData=null;
                        });
                        Future<Movie> futureData=loadAllMovies("&query="+val);
                        setState(() {
                          this.futureData=futureData;
                        });
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
          futureData !=null ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder <Movie>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Movie? data = snapshot.data;
                  return
                    GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1 / 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 2),
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(6),
                        itemCount: data!.results.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          Result movie=data.results[index];

                          return MovieItemWidget(movie: movie);
                        }
                    );
                } else if (snapshot.hasError) {
                  return const HasErrorWidget();
                }
                // By default show a loading spinner.
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {

                      return const MoviePlaceHolder();
                    }
                );
              },
            ),
          ) : SizedBox(),
        ],),
      )
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:practice/api/movie_response.dart';
import 'package:practice/api/movie_result.dart';
import 'package:practice/widgets/single_movie_item_widget.dart';
import 'package:practice/widgets/tabs/action_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/adventure_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/all_movies_tab_widget.dart';
import 'package:http/http.dart' as http;
import 'package:practice/widgets/tabs/animation_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/comedy_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/crime_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/documentary_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/drama_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/family_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/fantasy_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/history_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/horror_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/mystery_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/romance_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/scifi_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/thriller_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/war_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/western_movies_tab_widget.dart';
import 'package:search_page/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{


  late List<Result> moviesList;
  late Future<Movie> futureData;

  bool isLoading=false;

  List<String> tabs=['All Movies','Action','Horror','Adventure','Comedy',
                      'Thriller','Family','Animation','Crime','Documentary  ',
                      'Drama','Fantasy','History','Mystery','Romance','Sci-Fi','War','Western'];
  int selectedIndex=0;

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

    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No Movies Found")));
      return jsonDecode(response.body);

    }
  }

  getTabViewAccordingly(int tab){
    final tabsList=[
      const AllMoviesTabWidget(),
      ActionMoviesTabWidget(genere: ApiService.GENRE_ACTION),
      HorrorMoviesTabWidget(genere: ApiService.GENRE_HORROR),
      AdventureMoviesTabWidget(genere: ApiService.GENRE_ADVENTURE),
      ComedyMoviesTabWidget(genere: ApiService.GENRE_COMEDY),
      ThrillerMoviesTabWidget(genere: ApiService.GENRE_THRILLER),
      FamilyMoviesTabWidget(genere: ApiService.GENRE_FAMILY),
      AnimationMoviesTabWidget(genere: ApiService.GENRE_ANIMATION),
      CrimeMoviesTabWidget(genere: ApiService.GENRE_CRIME),
      DocumentaryMoviesTabWidget(genere: ApiService.GENRE_DOCUMENTRY),
      DramaMoviesTabWidget(genere: ApiService.GENRE_DRAMA),
      FantasyMoviesTabWidget(genere: ApiService.GENRE_FANTASY),
      HistoryMoviesTabWidget(genere: ApiService.GENRE_HISTORY),
      MysteryMoviesTabWidget(genere: ApiService.GENRE_MYSTERY),
      RomanceMoviesTabWidget(genere: ApiService.GENRE_ROMANCE),
      ScifiMoviesTabWidget(genere: ApiService.GENRE_SCIENCE_FICTION),
      WarMoviesTabWidget(genere: ApiService.GENRE_WAR),
      WesternMoviesTabWidget(genere: ApiService.GENRE_WESTERN),

    ];

    return tabsList[tab];
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title:const Text('Movies',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                  height: 30,
                  child:ListView.builder(
                      padding: const EdgeInsets.all(8),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      itemBuilder: (context, index){

                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedIndex=index;
                            });
                          },
                          child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),

                              ),
                              child: Text(tabs[index],style: index ==selectedIndex ? const TextStyle(fontWeight: FontWeight.w600):
                              const TextStyle(fontWeight: FontWeight.w400,color: Colors.grey),)),
                        );
                      })

              ),
            ),

            getTabViewAccordingly(selectedIndex),

          ],
        ),
      ),
    );
  }
}

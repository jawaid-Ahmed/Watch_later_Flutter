import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:practice/api/series.dart';
import 'package:practice/api/series_response.dart';
import 'package:practice/screens/search_screen.dart';
import 'package:practice/widgets/series_tabs/action_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/adventure_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/anim_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/comedy_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/crime_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/documentary_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/drama_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/familay_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/fantasy_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/history_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/horror_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/mystery_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/romance_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/scifi_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/thriller_series_tab_widget.dart';
import 'package:practice/widgets/series_tabs/war_series_tab_widget.dart';
import 'package:practice/widgets/single_serie_item_widget.dart';
import 'package:practice/widgets/tabs/action_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/adventure_movies_tab_widget.dart';
import 'package:practice/widgets/tabs/all_movies_tab_widget.dart';
import 'package:practice/widgets/series_tabs/all_series_tab_widget.dart';
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


class SeriesPage extends StatefulWidget {
  const SeriesPage({Key? key}) : super(key: key);

  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {



  bool isLoading=false;

  List<String> tabs=['All Series','Action','Horror','Adventure','Comedy',
    'Thriller','Family','Animation','Crime','Documentary  ',
    'Drama','Fantasy','History','Mystery','Romance','Sci-Fi','War','Western'];
  int selectedIndex=0;


  getTabViewAccordingly(int tab){
    final tabsList=[
      const AllSeriesTabWidget(),
      ActionSeriesTabWidget(genere: ApiService.GENRE_ACTION_ADVEN),
      HorrorSeriesTabWidget(genere: ApiService.GENRE_ACTION_ADVEN),
      AdventureSeriesTabWidget(genere: ApiService.GENRE_ACTION_ADVEN),
      ComedaySeriesTabWidget(genere: ApiService.GENRE_COMEDY),
      ThrillerSeriesTabWidget(genere: ApiService.GENRE_THRILLER),
      FamilySeriesTabWidget(genere: ApiService.GENRE_FAMILY),
      AnimSeriesTabWidget(genere: ApiService.GENRE_ANIMATION),
      CrimeSeriesTabWidget(genere: ApiService.GENRE_CRIME),
      DocumentarySeriesTabWidget(genere: ApiService.GENRE_DOCUMENTRY),
      DramaSeriesTabWidget(genere: ApiService.GENRE_DRAMA),
      FantasySeriesTabWidget(genere: ApiService.GENRE_SCI_FI_FANTASY),//noting in fantasy
      HistorySeriesTabWidget(genere: ApiService.GENRE_HISTORY),
      MysterySeriesTabWidget(genere: ApiService.GENRE_MYSTERY),
      RomanceSeriesTabWidget(genere: ApiService.GENRE_ROMANCE),
      SciFiSeriesTabWidget(genere: ApiService.GENRE_SCI_FI_FANTASY),
      WarSeriesTabWidget(genere: ApiService.GENRE_WAR_POLITICS),
      WesternMoviesTabWidget(genere: ApiService.GENRE_WESTERN),

    ];

    return tabsList[tab];
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Series',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      width: MediaQuery.of(context).size.width * 0.92,
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
                        placeholder: "search series ",
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> const SearchScreen()));}
                      )),
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
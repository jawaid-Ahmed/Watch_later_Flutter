// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:practice/screens/favourites_page.dart';
import 'package:practice/screens/home_page.dart';
import 'package:practice/screens/settings_page.dart';
import 'package:practice/screens/series_page.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex =0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  List<Widget> screens= const[
    HomePage(),
    FavouritesPage(),
    SeriesPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: screens
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BottomNavyBar(
          showElevation: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedIndex: _currentIndex,
          curve: Curves.easeInCirc,

          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                title: const Text('Movies'),
                icon:  const Icon(Icons.movie)
            ),
            BottomNavyBarItem(
                title: const Text('Favourites'),
                icon: const Icon(Icons.favorite)
            ),
            BottomNavyBarItem(
                title: const Text('Series'),
                icon: const Icon(Icons.tv)
            ),
            BottomNavyBarItem(
                title: const Text('Settings'),
                icon: const Icon(Icons.settings)
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:practice/providers/theme_provider.dart';
import 'package:practice/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Colors.grey.withOpacity(0.5),
    //     statusBarIconBrightness: Brightness.dark,
    //     statusBarBrightness:
    //         Platform.isAndroid ? Brightness.dark : Brightness.light,
    //     systemNavigationBarColor: Colors.white,
    //     systemNavigationBarDividerColor: Colors.grey,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //   ),
    // );

    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}

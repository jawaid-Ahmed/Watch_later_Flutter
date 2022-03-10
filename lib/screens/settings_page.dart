import 'package:flutter/material.dart';
import 'package:practice/widgets/change_theme_button_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: const [
          ChangeThemeButtonWidget()
        ],

      ),
      body:const SizedBox() ,
    );
  }
}


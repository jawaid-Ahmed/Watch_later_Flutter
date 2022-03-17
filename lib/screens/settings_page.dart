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

///to create and restore backup of hive database from flutter app
/*
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

  <application
  android:requestLegacyExternalStorage="true"
  Future<void> createBackup() async {
    if (Hive.box<Product>('products').isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Products Stored.')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Creating backup...')),
    );
    Map<String, dynamic> map = Hive.box<Product>('products')
        .toMap()
        .map((key, value) => MapEntry(key.toString(), value));
    String json = jsonEncode(map);
    await Permission.storage.request();
    Directory dir = await _getDirectory();
    String formattedDate = DateTime.now()
        .toString()
        .replaceAll('.', '-')
        .replaceAll(' ', '-')
        .replaceAll(':', '-');
    String path = '${dir.path}$formattedDate.json';//Change .json to your desired file format(like .barbackup or .hive).
    File backupFile = File(path);
    await backupFile.writeAsString(json);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Backup saved in folder Barcodes')),
    );}


  Future<Directory> _getDirectory() async {
    const String pathExt = 'Barcodes/';//This is the name of the folder where the backup is stored
    Directory newDirectory = Directory('/storage/emulated/0/' + pathExt);//Change this to any desired location where the folder will be created
    if (await newDirectory.exists() == false) {
      return newDirectory.create(recursive: true);
    }
    return newDirectory;
  }

  Future<void> restoreBackup() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restoring backup...')),
    );
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (file != null) {
      File files = File(file.files.single.path.toString());
      Hive.box<Product>('products').clear();
      Map<String, dynamic> map = jsonDecode(await files.readAsString());
      for (var i = 0; i < map.length; i++) {
        Product product = Product.fromJson(i.toString(), map);
        Hive.box<Product>('products').add(product);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restored Successfully...')),
      );
    }
  }*/
}


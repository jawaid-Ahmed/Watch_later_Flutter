import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/api/api_response.dart';
import 'package:practice/api/media.dart';
import 'package:practice/api/media_view_model.dart';
import 'package:practice/widgets/change_theme_button_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final _inputController = TextEditingController();
    ApiResponse apiResponse = Provider.of<MediaViewModel>(context).response;
    List<Media> mediaList = apiResponse.data as List<Media>;


    return Scaffold(
      appBar: AppBar(title: Text("Home",style: TextStyle(fontWeight: FontWeight.w500,
          color:Theme.of(context).primaryColor
      ),),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(onPressed: (){}, icon:  Icon(Icons.notifications,color: Theme.of(context).primaryColor,)),
          PopupMenuButton(
            icon: Icon(Icons.menu,color: Theme.of(context).primaryColor,),  //don't specify icon if you want 3 dot menu
            color: Theme.of(context).scaffoldBackgroundColor,
            itemBuilder: (context) =>const [
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
      body: Column(
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
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CupertinoSearchTextField(placeholder: "search movies series ",
                      controller: _inputController,
                      onChanged: (value){
                        // if (value.isNotEmpty) {
                        //   Provider.of<MediaViewModel>(context)
                        //       .setSelectedMedia();
                        //   Provider.of<MediaViewModel>(context,
                        //       listen: false)
                        //       .fetchMediaData(value);
                        // }
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
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(onPressed: (){},icon:const Icon(Icons.search),),
                )
              ],
            ),
          ),



        ],
      ) ,
    );

  }
}

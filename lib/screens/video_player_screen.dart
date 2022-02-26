import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoPlayerScreen extends StatefulWidget {
  String trailer_key;
  VideoPlayerScreen({Key? key,required this.trailer_key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.trailer_key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    _controller.fitHeight(size);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: YoutubePlayerBuilder(
            player: YoutubePlayer(controller: _controller,),
            builder: (context, player) {
              return Column(
                children: [
                  player,
                ],
              );
            }
        ),
      ),
    );
  }

}

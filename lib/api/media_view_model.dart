import 'package:flutter/cupertino.dart';
import 'package:practice/api/api_response.dart';
import 'package:practice/api/media.dart';
import 'package:practice/api/media_repository.dart';

class MediaViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.loading('Fetching artist data');

  late Media _media;

  ApiResponse get response {
    return _apiResponse;
  }

  Media get media {
    return _media;
  }

  Future<void> fetchMediaData(String value) async {
    try {
      List<Media> mediaList = await MediaRepository().fetchMediaList(value);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void setSelectedMedia(Media media) {
    _media = media;
    notifyListeners();
  }
}
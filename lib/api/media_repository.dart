
import 'package:practice/api/media.dart';
import 'package:practice/api/media_services.dart';

class MediaRepository {
  MediaService _mediaService = MediaService();

  Future<List<Media>> fetchMediaList(String value) async {
    dynamic response = await _mediaService.get(value);
    final jsonData = response['results'] as List;
    List<Media> mediaList =
    jsonData.map((tagJson) => Media.fromJson(tagJson)).toList();
    return mediaList;
  }
}
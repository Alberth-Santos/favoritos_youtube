import 'dart:convert';
import 'package:app_youtube/models/video.dart';
import 'package:http/http.dart' as http;

const apiKey = "AIzaSyAlxkfO4y9Yn99YngGzkMIhHjl08nmaZrA";

class Api {
  late String? _search;
  late String _nextToken;

  Future<List<Video>> search(String? search) async {
    _search = search;
    String url =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$apiKey&maxResults=1000";

    http.Response response = await http.get(Uri.parse(url));
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    String url =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$apiKey&maxResults=10&pageToken=$_nextToken";

    http.Response response = await http.get(Uri.parse(url));
    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];

      List<Video> videos = decoded["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos  api.dart");
    }
  }
}

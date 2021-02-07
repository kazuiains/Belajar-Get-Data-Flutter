import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:start_flutter/core/model/movie_resp.dart';

class Service {
  String nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=befc21d948862259da6f029c54831a9c&language=en-US&page=1&region=ID";
  String upComingUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=befc21d948862259da6f029c54831a9c&language=en-US&page=1";

  Future<MovieResp> getUpComing() async {
    try {
      print('Request: $upComingUrl');

      //  request API
      final response = await http.get(upComingUrl);

      if (response.statusCode == 200) {
        //success
        Map json = jsonDecode(response.body);
        print("Response: " + json.toString());

        MovieResp movieResp = MovieResp.fromJson(json);
        return movieResp;
      } else {
        //failed
        print("Response: Failed");
        return null;
      }
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  Future<MovieResp> getNowPlaying() async {
    try {
      print("Request: $nowPlayingUrl");

      // request API
      final response = await http.get(nowPlayingUrl);

      if (response.statusCode == 200) {
        // success
        Map json = jsonDecode(response.body);
        print("Response: " + json.toString());

        MovieResp movieResp = MovieResp.fromJson(json);
        return movieResp;
      } else {
        // failed
        print("Response: Failed");
        return null;
      }
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/src/config/config.dart';
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  Future<List<Movie>> getOnCinema() async {
    final url = Uri.https(urlApi, '3/movie/now_playing', {
      'api_key': apiKey,
      'language': language,
    });

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopular() async {
    final url = Uri.https(urlApi, '3/movie/popular', {
      'api_key': apiKey, 
      'language': language
    });

    return await _processResponse(url);
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
}

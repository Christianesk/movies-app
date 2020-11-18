import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/src/config/config.dart';
import 'package:movies/src/models/movie_model.dart';


class MoviesProvider {

  Future<List<Movie>> getOnCinema() async {

    final url = Uri.https(urlApi, '3/movie/now_playing',{
      'api-key':'1cb0d9b4dd98d6250b0dffcca928faf1',
      'language':language,
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    print(url);

    return [];

  }
}

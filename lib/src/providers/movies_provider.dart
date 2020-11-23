import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/src/config/config.dart';
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {

  int _popularPage = 0;

  List<Movie> _popularMovies = new List();

  final _popularStreamController = new StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams(){
    _popularStreamController?.close();
  }

  Future<List<Movie>> getOnCinema() async {
    final url = Uri.https(urlApi, '3/movie/now_playing', {
      'api_key': apiKey,
      'language': language,
    });

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopular() async {
    _popularPage++;

    final url = Uri.https(urlApi, '3/movie/popular', {
      'api_key': apiKey,
      'language': language,
      'page': _popularPage.toString()
    });

    final resp = await _processResponse(url);


    _popularMovies.addAll(resp);

    popularSink(_popularMovies);

    return resp;
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/src/config/config.dart';
import 'package:movies/src/models/actors_model.dart';

class ActorsProvider {
  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(urlApi, '/movie/$movieId/credits', {
      'api_key': apiKey,
      'language': language,
    });


    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }
}

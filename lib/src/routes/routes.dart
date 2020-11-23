import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_detail.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'detail': (BuildContext context) => MovieDetailPage(),
  };
}
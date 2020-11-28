import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class SearchData extends SearchDelegate {

  final moviesProvider = new MoviesProvider();
  /*String selection = '';

  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Ironman',
    'Capitan America',
  ];

  final moviesRecent = ['Spiderman', 'Capitan America'];*/

  @override
  List<Widget> buildActions(BuildContext context) {
    // AppBar actions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon to the left of the AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Create the results to display
    return Center(
     /*   child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.blueAccent,
      child: Text(selection),
    )*/);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // They are the suggestions that are shown when you type in the search engine
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if (snapshot.hasData) {

          final movies = snapshot.data;

          return ListView(
            children: movies.map((movie){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  close(context, null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'detail',arguments: movie);
                },
              );
            }).toList(),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

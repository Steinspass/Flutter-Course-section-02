import 'package:flutter/material.dart';
import 'package:movie_app/src/models/movie_model.dart';
import 'package:movie_app/src/providers/movies_provider.dart';


class DataSearch extends SearchDelegate {


  final moviesProvider = new MoviesProvider();

  final moviesRecent = [
    'spiderman',
    'aquaman',
    'batman',
    'ironman'
  ];










  @override
  List<Widget> buildActions(BuildContext context) {
    // Son las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query ='';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crear los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las Sugerencias que aparecen cuando la persona escribe 
    if (query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if( snapshot.hasData ){

          final movies = snapshot.data;

          return ListView(
            children: movies.map((movie){
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(movie.getPosterImage()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                    ),
                    title: Text(movie.title),
                    subtitle: Text(movie.releaseDate),
                    onTap: () {
                      close(context, null);
                      movie.uniqueId = '';
                      Navigator.pushNamed(context, 'detalle', arguments: movie);
                    },
                );
            }).toList()
          );
        } else {
            return Center(
                child: CircularProgressIndicator(),
            );
        }
      },
    );

  }


//  @override
//  Widget buildSuggestions(BuildContext context) {
//    // Son las Sugerencias que aparecen cuando la persona escribe 
//
//    final listSugesstion = (query.isEmpty) ? moviesRecent : 
//    movies.where( (p)=> p.toLowerCase().startsWith(query.toLowerCase()) ).toList();
//
//
//
//    return ListView.builder(
//      itemCount: listSugesstion.length,
//      itemBuilder: (context, i){
//        return ListTile(
//          leading: Icon(Icons.movie),
//          title: Text(listSugesstion[i]),
//        );
//      },
//    );
//  }

}
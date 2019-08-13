import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movie_app/src/models/actors_model.dart';
import 'package:movie_app/src/models/movie_model.dart';

class MoviesProvider{

  String _apikey   = '7bcf40aff5d7be80e294d763234a6930';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController?.close();
  }



  Future<List<Movie>> _processResponse(Uri url) async {
    
  final response = await http.get( url );
  final decodedData = json.decode(response.body);

  final movies = new Movies.fromJsonList(decodedData['results']);

  return movies.items;
}

  Future<List<Movie>> getInCinema() async {

  final url = Uri.https( _url, '3/movie/now_playing', {

    'api_key'  :  _apikey,
    'language' : _language

  });

    return await _processResponse(url);
}

  Future<List<Movie>> getPopular() async {

    if(_loading) return [];

    _loading = true;

    _popularPage++;

  final url = Uri.https( _url, '3/movie/popular', {

    'api_key'  :  _apikey,
    'language' : _language,
    'page'     : _popularPage.toString()

  });

    final resp = await _processResponse(url);

    _populars.addAll(resp);
    popularSink(_populars);

    _loading = false;

    return resp;
    
  }

  Future<List<Actor>> getCast( String movieId ) async {

    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      
      'api_key'  :  _apikey,
      'language' : _language

    });

    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }

  Future<List<Movie>> searchMovies(String query) async {

  final url = Uri.https( _url, '3/search/movie', {

    'api_key'  :  _apikey,
    'language' : _language,
    'query'    : query

  });

    return await _processResponse(url);
  }

}
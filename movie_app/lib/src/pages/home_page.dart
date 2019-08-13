import 'package:flutter/material.dart';
import 'package:movie_app/src/providers/movies_provider.dart';
import 'package:movie_app/src/search/search_delegate.dart';

import 'package:movie_app/src/widgets/card_swiper_widget.dart';
import 'package:movie_app/src/widgets/movie_horizontal.dart';



class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){ showSearch(context: context, delegate: DataSearch()); }, 
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {

      return FutureBuilder(
        future: moviesProvider.getInCinema(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

          if(snapshot.hasData){
            return CardSwiper( movies: snapshot.data );
          }else{
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator()
                )
              );
          }
          
        },
      );
  }

  Widget _footer(BuildContext ctx){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Popular', style: Theme.of(ctx).textTheme.subhead )
            ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              
              if(snapshot.hasData){
                return MoviesHorizontal(
                  movies: snapshot.data, 
                  nextPage: moviesProvider.getPopular
                  );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }



}
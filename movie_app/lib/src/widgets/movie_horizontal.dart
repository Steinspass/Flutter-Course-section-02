import 'package:flutter/material.dart';
import 'package:movie_app/src/models/movie_model.dart';
import 'package:movie_app/src/models/movie_model.dart' as prefix0;

class MoviesHorizontal extends StatelessWidget {
  
  final List<Movie> movies;
  final Function nextPage;

  MoviesHorizontal({ @required this.movies, @required this.nextPage });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( (){

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
          nextPage();
      }

    });


    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, i) => _createCards(context, movies[i]),
        //children: _cards(context),
      ),
    );
  }

  Widget _createCards(BuildContext context, Movie movie){

    movie.uniqueId = '${ movie.id }-poster';
    
    final card = Container(

       margin: EdgeInsets.only(right: 15.0),
       child: Column(
         children: <Widget>[
           Hero(
             tag: movie.uniqueId,
             child: ClipRRect(
               borderRadius: BorderRadius.circular(20.0) ,
               child: FadeInImage(
                 image: NetworkImage(movie.getPosterImage()),
                 placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
               ),
             ),
           ),
           SizedBox(height: 5.0),
           Text(
             movie.title,
             overflow: TextOverflow.ellipsis,
             style: Theme.of(context).textTheme.caption,
             )
         ],
       ),
     );

     return GestureDetector(
       child: card,
       onTap: (){
         Navigator.pushNamed(context, 'detalle', arguments: movie);
       },
     );
  }

 List<Widget> _cards(BuildContext context) {

   return movies.map((movie) {

     return Container(
       margin: EdgeInsets.only(right: 15.0),
       child: Column(
         children: <Widget>[
           ClipRRect(
             borderRadius: BorderRadius.circular(20.0) ,
             child: FadeInImage(
               image: NetworkImage(movie.getPosterImage()),
               placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
             ),
           ),
           SizedBox(height: 5.0),
           Text(
             movie.title,
             overflow: TextOverflow.ellipsis,
             style: Theme.of(context).textTheme.caption,
             )
         ],
       ),
     );

   }).toList();

 }
}
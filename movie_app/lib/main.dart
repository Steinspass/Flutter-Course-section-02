import 'package:flutter/material.dart';

import 'package:movie_app/src/pages/home_page.dart';
import 'package:movie_app/src/pages/movie_details_page.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      initialRoute: '/',
      routes: {
        '/'       : (BuildContext context) => HomePage(),
        'detalle' : (BuildContext context) => MovieDetailsPage(),
      },

    );
  }
}

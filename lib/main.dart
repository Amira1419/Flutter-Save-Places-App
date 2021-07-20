import 'package:flutter/material.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/screens/place_details_screen.dart';
import './providers/places.dart';
import './screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Remember Places',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home:PlacesList(),
        routes: {
          AddPlace.routeName : (ctx) => AddPlace(),
        },
      ),
    );
  }
}

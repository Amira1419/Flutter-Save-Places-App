import 'package:flutter/material.dart';
import 'package:great_places_app/providers/places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Places'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: (){
            Navigator.of(context).pushNamed(AddPlace.routeName);

          })
        ],),
      body: FutureBuilder(
        future:  Provider.of<Places>(context,listen: false).fetchDataFromDatabase(),
        builder: (ctx , snapShot) => snapShot.connectionState == ConnectionState.waiting ?CircularProgressIndicator():
        Consumer<Places>(
          builder: (ctx, placesData ,ch ) => placesData.userPlaces.length == 0 ? ch :ListView.builder(
            itemCount: placesData.userPlaces.length,
            itemBuilder: (ctx , index) { 
              print(index);
              return ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(placesData.userPlaces[index].image),
              ),
              title: Text(placesData.userPlaces[index].title),
              subtitle: Text('Visit Date : ${placesData.userPlaces[index].id}'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => PlaceDetailsScreen(placesData.userPlaces[index])));
              },
            );
            
            }
            ),
          child: Center(
          child: Text('There is no memories yet')
          // CircularProgressIndicator(),  
        ), 
        ),
      ) 

    );
  }
}
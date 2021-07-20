import 'package:great_places_app/helpers/db_helper.dart';

import '../models/place.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class Places with ChangeNotifier {
  List<Place> _userPlaces = [];

  List<Place> get userPlaces {
    return [..._userPlaces];
  }

  void addPlace(String title, File imageFile, PlaceLocation location) {
    Place newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: imageFile,
        location: location);
    _userPlaces.add(newPlace);
    notifyListeners();
    DBHelper.insert('places_table', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': newPlace.location.latitude,
      'longitude' : newPlace.location.longitude
    });
  }
  Future<void> fetchDataFromDatabase() async{
    final data = await DBHelper.getData('places_table');
    List<Place> fetchedList = [];
    data.forEach((element) { 
      fetchedList.add(Place(
        id: element['id'],
        title: element['title'],
        image: File(element['image']),
        location: PlaceLocation(latitude: element['latitude'],longitude: element['longitude'])
      ));
      
    });
    _userPlaces = fetchedList;
    notifyListeners();
  }
}

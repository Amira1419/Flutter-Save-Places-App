import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';



class LocationPreview extends StatefulWidget {
  final Function _saveLocation;
  LocationPreview(this._saveLocation);

  @override
  _LocationPreviewState createState() => _LocationPreviewState();
}

class _LocationPreviewState extends State<LocationPreview> {
  String _storedLocation;
  PlaceLocation _currentLocation;


  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    // print(locData.latitude);
    // print(locData.longitude);
    _currentLocation = PlaceLocation(latitude: locData.latitude ,longitude: locData.longitude);
    widget._saveLocation(_currentLocation);
    try{
      await _launchURL(locData.latitude, locData.longitude);
    }
    catch(error)
    {
      print(error);
    }


  }
  void _launchURL(double latitude,double longitude) async {
    //  MapsLauncher.launchCoordinates(latitude, longitude);
     final url = Uri.https('www.google.com', '/maps/search/',
          {'api': '1', 'query': '$latitude,$longitude'}).toString();
      // String googleMapUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      await canLaunch(url) ?
      await launch(url) :
      throw 'Could not launch Map';
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
                  
          height: MediaQuery.of(context).size.width * .75 ,
          width: MediaQuery.of(context).size.width * .75,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            
          ),
          child: _storedLocation == null? Image.asset('assets/images/location_placeholder.png') : Image.network(_storedLocation, fit: BoxFit.cover,width: double.infinity,),
       
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton.icon(onPressed: _getCurrentLocation, icon: Icon(Icons.location_on), label: Text('Current Location')),
            OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.map), label: Text('Location On the Map'))

          ],
        ),
        ],
      
    );
  }
}
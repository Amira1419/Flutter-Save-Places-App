import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:url_launcher/url_launcher.dart';


class PlaceDetailsScreen extends StatelessWidget {
  static  String routeName = '/PlaceDatails';
  final Place savedPlace;
  const PlaceDetailsScreen(this.savedPlace);

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(this.savedPlace.title),
        
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.only(right: 10,left: 10),
            width: width,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              
            ),
            child: Image.file(savedPlace.image , fit: BoxFit.cover,width: double.infinity,),
          ),
          OutlinedButton(child: Text('View Location on Google Maps'),
          onPressed: () async {
            try{ 
            await _launchURL(savedPlace.location.latitude,savedPlace.location.longitude);
            }catch(error)
            {
              print(error);
            }
            })
          ],
        ),
      ),
    );
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
}
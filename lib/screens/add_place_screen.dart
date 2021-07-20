import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/providers/places.dart';
import 'package:great_places_app/widgets/image_perviewing_widget.dart';
import 'package:great_places_app/widgets/location_previewing_widget.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatefulWidget {
  static String routeName = '/AddPlace';

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  File _pickedImage;
  PlaceLocation _pickedLocation;
  final _titleController = TextEditingController();


  void _saveImage(File pickedImage)
  {
    _pickedImage = pickedImage;
  }
  void _saveLocation(PlaceLocation pickedLocation)
  {
    _pickedLocation= pickedLocation;
  }

  void _savePlace()
  {
    if( _titleController.text.isEmpty || _pickedImage == null)
    {
      return;
    }
    else{
      Provider.of<Places>(context,listen: false).addPlace(_titleController.text, _pickedImage,_pickedLocation);
      Navigator.of(context).pop();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Place To Remember'),
      actions: [
        TextButton(onPressed: _savePlace , child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),))
      ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ImagePreview(_saveImage),
            SizedBox(
              height: 20,
            ),
            LocationPreview(_saveLocation)
          ],
          ),
        ),
        
      ),
    );
  }
}
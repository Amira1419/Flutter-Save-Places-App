import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImagePreview extends StatefulWidget {
    final Function saveImage;
    ImagePreview(this.saveImage);


  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  File _storedImage;



  Future<void> _pickImage () async
  {
    ImagePicker _picker = new ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if(pickedFile == null)
    {
      print('picked file is null');
      return;
    }
    
      setState(() {
          _storedImage = File(pickedFile.path);
        });


    final dirPath = await getApplicationDocumentsDirectory();
    final fileName = path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy('${dirPath.path}/${fileName}');
    print(savedImage.toString());
    widget.saveImage(savedImage);

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: width,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            
          ),
          child: _storedImage == null? Image.asset('assets/images/camera_placeholder.png') : Image.file(_storedImage, fit: BoxFit.cover,width: double.infinity,),
        ),
        OutlinedButton(child: Text('Pick a photo'),
        onPressed: _pickImage,)

      ],
      
    );
  }
}
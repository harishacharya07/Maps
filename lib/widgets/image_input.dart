import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systempath;

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectedImage;
  ImageInput(this.onSelectedImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  @override
  Widget build(BuildContext context) {

    Future<void> imagePicker() async {
      final imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 100,
      );
      if(imageFile == null) {
        return;
      }
      setState(() {
        _storedImage = imageFile;
      });

      final appDir = await systempath.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');
      widget.onSelectedImage(savedImage); // widget. is global property get accessed form the  base class
    }

    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No images selected',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: imagePicker,
            icon: Icon(Icons.camera),
            label: Text('Take the Picture'),
            textColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

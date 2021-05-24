import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/great_places.dart';
import '../widgets/input_location.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-places';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _imagedPicked;

  void _selectedImage(File pickedImage) {
    _imagedPicked = pickedImage;
  }

  void _savePlace() {
    // if (_titleController.text.isEmpty || _imagedPicked == null) {
    //   return;
    // }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _imagedPicked,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectedImage),
                    SizedBox(height: 10,),
                    InputLocation(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savePlace,
            icon: Icon(
              Icons.place,
              color: Colors.white,
            ),
            label: Text(
              'Add Places',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}

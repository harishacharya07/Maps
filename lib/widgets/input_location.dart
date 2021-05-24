import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/map_screen.dart';
import '../helpers/location_helper.dart';

class InputLocation extends StatefulWidget {
  @override
  _InputLocationState createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocation> {
  String _previewImageUrl;

  Future<void> _userLocation() async {
    final locData = await Location().getLocation();
    final previewImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImageUrl = previewImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectOnMap() async {
      final LatLng selectedLocation = await Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (ctx) => MapScreen(
            isPlacesSelected: true,
          ),
        ),
      );
      if(selectedLocation == null) {
        return;
      }
    }

    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Center(
                  child: Text('No image selected'),
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              onPressed: _userLocation,
              icon: Icon(Icons.location_on),
              label: Text('Choose'),
            ),
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Open map'),
            ),
          ],
        )
      ],
    );
  }
}

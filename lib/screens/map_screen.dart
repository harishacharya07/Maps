import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/places.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isPlacesSelected;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isPlacesSelected = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng selectedPosition;

  void _selectLocation(LatLng location) {
    setState(() {
      selectedPosition = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Location'),
        actions: [
          if (widget.isPlacesSelected)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: selectedPosition == null ? null : () {
                Navigator.of(context).pop(selectedPosition);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isPlacesSelected ? _selectLocation : null,
        markers: selectedPosition == null
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: selectedPosition,
                ),
              },
      ),
    );
  }
}

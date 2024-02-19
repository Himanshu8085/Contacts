import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;
  LatLng currentloc = LatLng(21.1498, 79.0806);
  LatLng returnpos = LatLng(0, 0);
  Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Address location"),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: currentloc),
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: (controller) {
            mapController = controller;
            addmarker("test", currentloc);
          },
          markers: _markers.values.toSet(),
        ));
  }

  addmarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      onTap: () {
        debugPrint('Tapped');
        Navigator.pop(context, returnpos);
      },
      draggable: true,
      onDragEnd: ((LatLng newPosition) {
        print(newPosition.latitude);
        print(newPosition.longitude);
        returnpos = newPosition;
      }),
    );
    _markers[id] = marker;
    setState(() {});
  }
}

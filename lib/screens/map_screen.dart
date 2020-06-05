import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplaces/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({this.initialLocation = const PlaceLocation(latitude: 28.7041,longitude: 77.1025), this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if(widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null ? null : (){   // jb tk location pick nhi krenge tb tk yeh button disabled rhega
                Navigator.pop(context, _pickedLocation);  // It will return the picked location
          },)
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting) ? null : {
          Marker(
              markerId: MarkerId('m1'),
              position: _pickedLocation ??    // if pickedlocation is null then stmt after ?? will execute
                  LatLng(widget.initialLocation.latitude,
                      widget.initialLocation.longitude)),
        },
      ),
    );
  }
}

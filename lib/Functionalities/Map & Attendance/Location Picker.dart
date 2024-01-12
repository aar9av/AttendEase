import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class LocationPicker extends StatefulWidget {
  final LatLng subjectLocation;

  const LocationPicker({
    Key? key,
    required this.subjectLocation,
  }) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController? mapController;
  late LatLng currentLocation;
  MapType currentMapType = MapType.normal;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    currentLocation = widget.subjectLocation;
    checkLocationStatus();
  }

  Future<void> checkLocationStatus() async{
    bool isLocationEnabled = await location.serviceEnabled();
    if(!isLocationEnabled){
      isLocationEnabled = await location.requestService();
      if(!isLocationEnabled){
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
              _animateToCurrentLocation(); // Automatically animate to current location on map creation
            },
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 15,
            ),
            onCameraMove: (CameraPosition position) {
              setState(() {
                currentLocation = position.target;
              });
            },
            myLocationEnabled: true,
            mapType: currentMapType, // Set the map type
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              child: Image.asset(
                'Assets/LocationMarker.png',
                height: 100,
              ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(
              top: 60,
              left: MediaQuery.of(context).size.width - 50,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(200),
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  currentMapType = currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
                });
              },
              child: Icon(
                Icons.layers,
                color: Colors.grey.shade600,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: TextButton(
          onPressed: () {
            Navigator.pop(context, currentLocation);
          },
          child: const Text(
            'Save Location',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _animateToCurrentLocation() async {
    if (mapController != null) {
      await mapController!.animateCamera(
        CameraUpdate.newLatLng(currentLocation),
      );
    }
  }
}
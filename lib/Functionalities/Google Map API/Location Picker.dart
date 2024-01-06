// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Get Current Location.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController? mapController;
  late LatLng currentLocation = const LatLng(23.2152, 77.4099);

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    GetLocation getLocationInstance = GetLocation();

    try {
      Position userLocation = await getLocationInstance.getCurrentLocation();
      setState(() {
        currentLocation = LatLng(userLocation.latitude, userLocation.longitude);
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              child: Image.asset(
                'Assets/Images/LocationMarker.png',
                height: 100,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: ElevatedButton(
          onPressed: () {

            Navigator.pop(context, LocationData.fromMap({
              "latitude": currentLocation.latitude,
              "longitude": currentLocation.longitude,
            }));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
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

class LocationData {
  final double latitude;
  final double longitude;

  LocationData({
    required this.latitude,
    required this.longitude,
  });

  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      latitude: map['latitude'] ?? 23.2152,
      longitude: map['longitude'] ?? 77.4099,
    );
  }
}
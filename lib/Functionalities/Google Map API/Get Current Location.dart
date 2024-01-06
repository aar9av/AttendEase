// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';

class GetLocation{
  Future<Position> getCurrentLocation() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied || permission==LocationPermission.deniedForever){
      print('Location Permission Denied');
      LocationPermission ask = await Geolocator.requestPermission();
    }
    else{
      Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      return currentPosition;
    }
    return {0.0, 0.0} as Position;
  }
}
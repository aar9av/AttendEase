import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../CloudStore/Subject.dart';

markAttendance() async{
  var subjects = await Subject.fetchAllSubjects();
  var day = DateTime.now().weekday-1;
  var hour = DateTime.now().hour;
  for(var subject in subjects){
    if(subject['timeSlots'][day]['isChecked']){
      if(subject['timeSlots'][day]['time']['hour'] == hour){
        Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        LatLng lectureLocation = parseLatLng(subject['location']);
        double distanceInMeters = Geolocator.distanceBetween(
          userLocation.latitude,
          userLocation.longitude,
          lectureLocation.latitude,
          lectureLocation.longitude,
        );
        if(distanceInMeters <= 50) {
          print('Write your code Here');
          print('Distance: $distanceInMeters');
          // await Subject.editSubject(
          //   context,
          //   subject['id'],
          //   'aalo',
          //   subject['code'],
          //   subject['coordinator'],
          //   subject['minAttendancePercent'],
          //   subject['location'],
          //   subject['timeSlots'],
          // );
          print('Done');
        }
      }
    }
  }
}

LatLng parseLatLng(String coordinatesString) {
  String cleanedString = coordinatesString.replaceAll('(', '').replaceAll(')', '');
  List<String> parts = cleanedString.split(', ');

  double latitude = double.parse(parts[0]);
  double longitude = double.parse(parts[1]);

  return LatLng(latitude, longitude);
}
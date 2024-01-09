import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../CloudStore/Subject.dart';

markAttendance() async{
  var subjects = await Subject.fetchAllSubjects();
  var day = DateTime.now().weekday-1;
  var hour = DateTime.now().hour;
  print('start');
  for(var subject in subjects){
    print('subject');
    if(subject['timeSlots'][day]['isChecked']){
      print('day verified');
      if(subject['timeSlots'][day]['time']['hour'] == hour){
        print('hour verified');
        Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        GeoPoint lectureLocation = subject['location'];
        double distanceInMeters = Geolocator.distanceBetween(
          userLocation.latitude,
          userLocation.longitude,
          lectureLocation.latitude,
          lectureLocation.longitude,
        );
        if(distanceInMeters <= 500000000) {
          print('Location verified');
          print('Distance: $distanceInMeters');
          print(subject['name']);
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
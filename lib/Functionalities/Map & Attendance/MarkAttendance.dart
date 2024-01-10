import 'package:attend_easy/Functionalities/CloudStore/Attendance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../CloudStore/Subject.dart';

markAttendance() async{
  var subjects = await Subject.fetchAllSubjects();
  var day = DateTime.now().weekday-1;
  var hour = DateTime.now().hour;

  for(var subject in subjects){
    if(subject['timeSlots'][day]['isChecked']){
      if(subject['timeSlots'][day]['time']['hour'] == hour){
        bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
        if(!isLocationEnabled){
          // ----------------------------- Send Notification
        } else {
          Position userLocation = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          GeoPoint lectureLocation = subject['location'];
          double distanceInMeters = Geolocator.distanceBetween(
            userLocation.latitude,
            userLocation.longitude,
            lectureLocation.latitude,
            lectureLocation.longitude,
          );
          if (distanceInMeters <= 50) {
            Attendance.setAttendanceStatus(subject['id']);
          }
        }
      }

      if(subject['timeSlots'][day]['time']['hour'] == hour - 1) {
        var attendanceData = await Attendance.fetchAttendance(subject['id']);
        bool isTodayEntryExist = attendanceData.any((attendance) {
          DateTime entryDate = (attendance['dateTime'] as Timestamp).toDate();
          return entryDate.year == DateTime.now().year &&
              entryDate.month == DateTime.now().month &&
              entryDate.day == DateTime.now().day;
        });
        if(!isTodayEntryExist) {
          if (subject['today']) {
            await Attendance.addAttendanceDocument(subject['id'], 'Present');
            // ----------------------------- Send Notification
          } else {
            await Attendance.addAttendanceDocument(subject['id'], 'Absent');
            // ----------------------------- Send Notification
          }
        }
        Attendance.resetAttendanceStatus(subject['id']);
      }
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pgee/services/firebase_auth_service.dart';

class FirebaseProgramService {
  static Future<DocumentSnapshot<Map<String, dynamic>>> getToday(
      int weekday) async {
    // change the int to string based on the day of the week
    var stringweek = "";
    switch (weekday) {
      case 1:
        stringweek = "monday";
        break;
      case 2:
        stringweek = "tuesday";
        break;
      case 3:
        stringweek = "wednesday";
        break;
      case 4:
        stringweek = "thursday";
        break;
      case 5:
        stringweek = "friday";
        break;
      case 6:
        stringweek = "saturday";
        break;
      case 7:
        stringweek = "sunday";
        break;
    }
    var className = await FirebaseAuthService.getClass();
    print(className);
    var classDoc =
        FirebaseFirestore.instance.collection('classes').doc(className);
    var programDoc = await classDoc.collection('program').doc(stringweek);
    print(programDoc.get().then((value) => value.get("1")));
    return programDoc.get();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>?>> getTeachers() async {
    var className = await FirebaseAuthService.getClass();
    var classDoc = await FirebaseFirestore.instance
        .collection('classes')
        .doc(className)
        .get();

    var teachers = await classDoc.get("teachers");

    return teachers;
  }
}

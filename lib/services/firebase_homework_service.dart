import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHomeworkService {
  static Stream<QuerySnapshot<Map<String, dynamic>>> GetHomeworks(
      {bool descending = false}) {
    var auth = FirebaseAuth.instance;
    var store = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("homeworks")
        .orderBy('time', descending: descending)
        .get();

    return store.asStream();
  }
}

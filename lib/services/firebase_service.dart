import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  static Future<bool> isAdmin() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      return value.get("role") == 'admin';
    });
  }

  static Future signIn(
      BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    print("sign");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Грешка"),
          content: Text(e.toString()),
          actions: [
            ElevatedButton(
              child: Text("ОК"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
      rethrow;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Влязохте")));

    if (password == "12345678") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Препоръчително е да си смените паролата.")));
    }

    print("signIn: ${FirebaseAuth.instance.currentUser?.email}");
    Navigator.pushReplacementNamed(context, "/home");
  }
}

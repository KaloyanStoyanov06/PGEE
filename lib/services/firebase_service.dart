import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pgee/firebase_options.dart';
import 'package:pgee/pages/admin/users.dart';

class FirebaseService {
  static Future<bool> isAdmin() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      return value.get("isAdmin");
    });
  }

  static Future signIn(
      BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Грешка"),
          content: Text(e.toString()),
          actions: [
            ElevatedButton(
              child: const Text("ОК"),
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

    Navigator.pushReplacementNamed(context, "/home");
  }

  static Future signUp(
      BuildContext context,
      String email,
      String name,
      String role,
      String className,
      String numberInClass,
      String teachItem,
      bool isAdmin) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));

    if (className.isEmpty) {
      className = "";
    }

    if (email.isEmpty ||
        name.isEmpty ||
        role.isEmpty ||
        (role == "student" && className.isEmpty) ||
        (role == 'student' && numberInClass.isEmpty)) {
      Navigator.pop(context);
      // throw a new error in a dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Грешка"),
          content: Text("Всичко трябва да бъде попълнено"),
          actions: [
            ElevatedButton(
              child: const Text("ОК"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
      return;
    }

    FirebaseApp tempApp = await Firebase.initializeApp(
        name: "TempoaryApp", options: DefaultFirebaseOptions.currentPlatform);
    UserCredential user;

    try {
      user = await FirebaseAuth.instanceFor(app: tempApp)
          .createUserWithEmailAndPassword(
              email: email.trim(), password: "12345678");
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Грешка"),
          content: Text(e.toString()),
          actions: [
            ElevatedButton(
              child: const Text("ОК"),
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

    var store = FirebaseFirestore.instance.collection("users");
    var doc = store.doc(user.user!.uid);
    if (role == "admin") {
      doc.set({
        "email": email.trim(),
        "name": name.trim(),
        "role": role.trim(),
      });
    } else if (role == "teacher") {
      doc.set({
        "email": email.trim(),
        "name": name.trim(),
        "role": role.trim(),
        "class": className.trim(),
        "teachItem": teachItem.trim()
      });
    } else {
      doc.set({
        "email": email.trim(),
        "name": name.trim(),
        "role": role.trim(),
        "class": className.trim(),
        "numberInClass": int.parse(numberInClass.trim())
      });
    }
    tempApp.delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Регистриран е нов потребител")));

    Navigator.pop(context);
  }

  static Future changePassword(BuildContext context, String email) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Грешка"),
          content: Text(e.toString()),
          actions: [
            ElevatedButton(
              child: const Text("ОК"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
      rethrow;
    }

    Navigator.pop(context);
    Navigator.pop(context);
  }

  static Future updateUser(
    BuildContext context,
    String email,
    String name,
    String role,
    String className,
    String numberInClass,
    String teachItem,
    bool isAdmin,
    String uid,
  ) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));

    if (email.isEmpty ||
        name.isEmpty ||
        role.isEmpty ||
        (role != "teacher" && className.isEmpty) ||
        (role == 'student' && numberInClass.isEmpty)) {
      Navigator.pop(context);
      // throw a new error in a dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Грешка"),
          content: Text("Всичко трябва да бъде попълнено"),
          actions: [
            ElevatedButton(
              child: const Text("ОК"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
      return;
    }

    var doc = FirebaseFirestore.instance.collection("users").doc(uid);

    doc.update({
      "email": email.trim(),
      'name': name.trim(),
      "role": role.trim(),
      "class": className.trim(),
    });

    if (role == 'student') {
      doc.update({
        "numberInClass": int.parse(numberInClass.trim()),
      });
    } else if (role == 'teacher') {
      doc.update({
        "teachItem": teachItem.trim(),
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Успешно редактиран профил"),
      duration: Duration(seconds: 5),
      elevation: 20,
    ));

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ModUsersPage(),
      ),
    );
  }

  static Future deleteUser(BuildContext context, String uid) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));

    var store = FirebaseFirestore.instance.collection("users").doc(uid);
    store.delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Успешно изтрит профил"),
      duration: Duration(seconds: 5),
      elevation: 20,
    ));

    Navigator.pop(context);
  }
}

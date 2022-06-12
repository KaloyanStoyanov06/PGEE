import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeekPage extends StatefulWidget {
  WeekPage({Key? key}) : super(key: key);

  @override
  State<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Седмица"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(FirebaseAuth.instance.currentUser?.email ?? ""),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pgee/components/day.dart';

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
        body: PageView(
          allowImplicitScrolling: true,
          controller: PageController(
            initialPage: DateTime.now().weekday - 1,
            keepPage: true,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            Day(day: 1, title: "Понеделник"),
            Day(day: 2, title: "Вторник"),
            Day(day: 3, title: "Сряда"),
            Day(day: 4, title: "Четвъртък"),
            Day(day: 5, title: "Петък"),
          ],
        ));
  }
}

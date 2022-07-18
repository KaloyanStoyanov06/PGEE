import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pgee/components/school_card.dart';
import 'package:pgee/services/firebase_program_service.dart';

class Day extends StatefulWidget {
  Day({Key? key, required this.day, required this.title}) : super(key: key);

  final int day;
  final String title;

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseProgramService.getDayClass(widget.day),
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        var data = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return SchoolCard(
                subjectNumber: index + 1,
                subjectName: data.get((index + 1).toString()),
                teacherName: "Професор",
                startingTime: const TimeOfDay(
                  hour: 7,
                  minute: 45,
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: data.data()!.length,
          ),
        );
      },
    );
  }
}

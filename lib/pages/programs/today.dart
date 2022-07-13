import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/components/drawer.dart';
import 'package:pgee/components/school_card.dart';
import 'package:pgee/services/firebase_program_service.dart';

class TodayPage extends StatefulWidget {
  TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  var today = DateTime.now().weekday;

  // Day of the week
  String dayOfWeek() {
    switch (today) {
      case 1:
        return 'Понеделник';
      case 2:
        return 'Вторник';
      case 3:
        return 'Сряда';
      case 4:
        return 'Четвъртък';
      case 5:
        return 'Петък';
      case 6:
        return 'Събота';
      case 7:
        return 'Неделя';
      default:
        return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (today == 6 || today == 7) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Днес е Почивен ден"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Text(
          'Почивен ден',
          style: Theme.of(context).textTheme.headlineLarge,
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Днес е ${dayOfWeek()}"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: FirebaseProgramService.getDayClass(today),
        builder: ((context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var data = snapshot.data!;
          //TODO: IMPLEMENT GETTEACHERS METHOD TO THE FULLEST
          // DocumentSnapshot<Map<String, dynamic>?> teachers =
          //     FirebaseProgramService.getTeachers().then(
          //   (value) => value.data(),
          // );
          // print("teachers: $teachers");

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return SchoolCard(
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
          );
        }),
      ),
    );
  }
}

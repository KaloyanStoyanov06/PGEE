import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/components/drawer.dart';
import 'package:pgee/components/school_card.dart';
import 'package:pgee/services/firebase_program_service.dart';

class TommorowPage extends StatefulWidget {
  TommorowPage({Key? key}) : super(key: key);

  @override
  State<TommorowPage> createState() => _TommorowPageState();
}

class _TommorowPageState extends State<TommorowPage> {
  var tommorow = DateTime.now().weekday + 1;

  // Day of the week
  String dayOfWeek() {
    switch (tommorow) {
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
    if (tommorow == 6 || tommorow == 7) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Утре е Почивен ден"),
        ),
        body: Center(
            child: Text(
          'Успокой са малко.\nПочивай си',
          style: Theme.of(context).textTheme.headlineLarge,
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Утре е ${dayOfWeek()}"),
      ),
      body: FutureBuilder(
        future: FirebaseProgramService.getDayClass(tommorow),
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
          );
        }),
      ),
    );
  }
}

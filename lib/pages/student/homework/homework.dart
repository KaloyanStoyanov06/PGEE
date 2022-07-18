import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgee/components/student/homework_tile.dart';
import 'package:pgee/services/firebase_homework_service.dart';
import 'package:pgee/services/style_ui_service.dart';

class HomeworkPage extends StatefulWidget {
  HomeworkPage({Key? key}) : super(key: key);

  @override
  State<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  Stream<QuerySnapshot<Map<String, dynamic>>> _homeworks =
      FirebaseHomeworkService.GetHomeworks();

  var filterIcon = Icon(Icons.arrow_downward);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Домашни'),
        actions: [
          IconButton(
            tooltip: "Добави домашна",
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pushNamed(context, '/homework/create');
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            tooltip: "Филтрирай по най-далечна и най-близка домашна",
            onPressed: () {
              HapticFeedback.heavyImpact();
              setState(() {
                _homeworks = FirebaseHomeworkService.GetHomeworks(
                    descending: filterIcon.icon == Icons.arrow_downward);
                filterIcon = filterIcon.icon == Icons.arrow_downward
                    ? Icon(Icons.arrow_upward)
                    : Icon(Icons.arrow_downward);
              });
            },
            icon: filterIcon,
          )
        ],
      ),
      body: StreamBuilder(
        stream: _homeworks,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          var data = snapshot.data!.docs.asMap();

          if (data.isEmpty) {
            return Center(
              child: Text(
                'Няма домашни',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              setState(() {
                _homeworks = Stream.empty();
                _homeworks = FirebaseHomeworkService.GetHomeworks();
              });

              return Future.value();
            },
            child: ListView.separated(
              // physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                var homework = data[index]!;
                print(homework['time']);
                return HomeworkTile(
                  className: homework['class'],
                  description: homework['description'],
                  time: DateTime.fromMillisecondsSinceEpoch(
                      homework['time'].millisecondsSinceEpoch),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
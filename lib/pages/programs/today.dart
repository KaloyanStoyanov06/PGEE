import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/components/drawer.dart';

class TodayPage extends StatefulWidget {
  TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  // TODO: CHANGE BACK TO DateTime.now().weekday;
  var today = 4;

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
          title: const Text("Днес"),
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
        title: Text("Днес е " + dayOfWeek()),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(FirebaseAuth.instance.currentUser?.email ?? ""),
            ElevatedButton(
                onPressed: (() => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Влязохте")))),
                child: const Text("Hello"))
          ],
        ),
      ),
    );
  }
}

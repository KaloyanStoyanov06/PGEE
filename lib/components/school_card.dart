import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay add({int hour = 0, int minute = 0}) {
    minute = (hour * 60) + minute;

    if (minute == 0) {
      return this;
    } else {
      int mofd = this.hour * 60 + this.minute;
      int newMofd = ((minute % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        return replacing(hour: newHour, minute: newMinute);
      }
    }
  }
}

class SchoolCard extends StatelessWidget {
  SchoolCard(
      {Key? key,
      required this.subjectName,
      required this.teacherName,
      required this.startingTime})
      : super(key: key);

  final String subjectName;
  final String teacherName;
  final TimeOfDay startingTime;
  late TimeOfDay endingTime = startingTime.add(minute: 40);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subjectName),
      subtitle: Text(teacherName),
      enableFeedback: true,
      trailing: Text(
        '${startingTime.hour}:${startingTime.minute} - ${endingTime.hour}:${endingTime.minute}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

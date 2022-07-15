import 'package:flutter/material.dart';

class HomeworkTile extends StatelessWidget {
  HomeworkTile(
      {Key? key,
      required this.className,
      required this.description,
      required this.time})
      : super(key: key);

  final String className;
  final String description;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(className),
      subtitle: Text(description),
      trailing: Text(
          textAlign: TextAlign.center,
          '${time.hour}:${time.minute}\n${time.day}/${time.month}/${time.year}'),
    );
  }
}

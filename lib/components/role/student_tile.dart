import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  const StudentTile(
      {Key? key,
      required this.name,
      required this.email,
      required this.className,
      required this.numberInClass})
      : super(key: key);

  final String name;
  final String className;
  final String email;
  final int numberInClass;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text("Ученик  |  ${className}  ${numberInClass} №"),
    );
  }
}

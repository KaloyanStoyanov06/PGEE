import 'package:flutter/material.dart';

class StudentTile extends StatefulWidget {
  const StudentTile(
      {Key? key,
      required this.name,
      required this.email,
      required this.className,
      required this.numberInClass,
      required this.isAdmin})
      : super(key: key);

  final String name;
  final String className;
  final String email;
  final int numberInClass;
  final bool isAdmin;

  @override
  State<StudentTile> createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  String subtitle = "";

  @override
  void initState() {
    subtitle = "Ученик  |  ${widget.className}  ${widget.numberInClass} №";
    if (widget.isAdmin) {
      subtitle += "\nАдминистратор";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      subtitle: Text(subtitle),
    );
  }
}

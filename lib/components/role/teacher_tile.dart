import 'dart:ffi';

import 'package:flutter/material.dart';

class TeacherTile extends StatefulWidget {
  const TeacherTile(
      {Key? key,
      required this.name,
      required this.email,
      required this.className,
      required this.teachItem,
      required this.isAdmin})
      : super(key: key);

  final String name;
  final String className;
  final String email;
  final String teachItem;
  final bool isAdmin;

  @override
  State<TeacherTile> createState() => _TeacherTileState();
}

class _TeacherTileState extends State<TeacherTile> {
  var subtitle = "";

  @override
  void initState() {
    subtitle = "Учител по ${widget.teachItem}";
    if (widget.className.isNotEmpty) {
      setState(() {
        subtitle += "\nКласен ръководител на ${widget.className}";
      });
    }

    if (widget.isAdmin) {
      setState(() {
        subtitle += "\nАдминистратор";
      });
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

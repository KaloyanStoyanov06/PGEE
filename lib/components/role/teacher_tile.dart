import 'package:flutter/material.dart';

class TeacherTile extends StatefulWidget {
  const TeacherTile(
      {Key? key,
      required this.name,
      required this.email,
      required this.className,
      required this.teachItem})
      : super(key: key);

  final String name;
  final String className;
  final String email;
  final String teachItem;

  @override
  State<TeacherTile> createState() => _TeacherTileState();
}

class _TeacherTileState extends State<TeacherTile> {
  var subtitle = "";

  @override
  void initState() {
    subtitle = "Учител по ${widget.teachItem}";
    if (true) {
      setState(() {
        subtitle += "\nКласен ръководител на ${widget.className}";
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

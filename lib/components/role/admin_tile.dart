import 'package:flutter/material.dart';

class AdminTile extends StatelessWidget {
  const AdminTile({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text("Администратор"),
    );
  }
}

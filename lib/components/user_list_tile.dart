import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserListTile extends StatelessWidget {
  const UserListTile(
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
      subtitle: Text("${className} | ${numberInClass} №"),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          // Navigator.pushNamed(context, '/mod-users-edit', arguments: document);
        },
      ),
    );
  }
}

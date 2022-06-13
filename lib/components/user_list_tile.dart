import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserListTile extends StatelessWidget {
  const UserListTile(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.classNumber})
      : super(key: key);

  final String firstName;
  final String lastName;
  final String classNumber;
  final String email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$firstName $lastName'),
      subtitle: Text(classNumber),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          // Navigator.pushNamed(context, '/mod-users-edit', arguments: document);
        },
      ),
    );
  }
}

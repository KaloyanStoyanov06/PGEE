import 'package:flutter/material.dart';

class AdminFunctions extends StatelessWidget {
  const AdminFunctions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.app_registration_rounded),
          title: Text("Регистриране на нов потребител"),
          onTap: () {
            Navigator.pushNamed(context, '/sign-up');
          },
        ),
        ListTile(
          leading: Icon(Icons.edit_rounded),
          title: Text("Модифициране на потребител"),
          onTap: () {
            Navigator.pushNamed(context, '/mod-users');
          },
        ),
      ],
    );
  }
}

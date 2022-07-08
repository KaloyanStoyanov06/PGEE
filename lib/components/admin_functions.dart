import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminFunctions extends StatelessWidget {
  const AdminFunctions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: Icon(Icons.app_registration_rounded),
          title: Text("Регистриране на нов потребител"),
          onTap: () {
            HapticFeedback.heavyImpact();
            Navigator.pushNamed(context, '/sign-up');
          },
        ),
        ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: Icon(Icons.edit_rounded),
          title: Text("Модифициране на потребител"),
          onTap: () {
            HapticFeedback.heavyImpact();
            Navigator.pushNamed(context, '/mod-users');
          },
        ),
      ],
    );
  }
}

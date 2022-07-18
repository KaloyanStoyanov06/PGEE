import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/services/firebase_auth_service.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Забравена парола"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          labelText: "Емайл",
        ),
        controller: email,
        keyboardType: TextInputType.emailAddress,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            FirebaseAuthService.changePassword(context, email.text);
          },
          child: Text("Изпрати"),
        ),
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text("Откажи")),
      ],
    );
  }
}

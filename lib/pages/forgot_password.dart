import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        decoration: InputDecoration(
          labelText: "Емайл",
        ),
        controller: email,
        keyboardType: TextInputType.emailAddress,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => PasswordChange(),
          child: Text("Изпрати"),
        ),
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text("Откажи")),
      ],
    );
  }

  Future PasswordChange() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Грешка"),
          content: Text(e.toString()),
          actions: [
            ElevatedButton(
              child: Text("ОК"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
      rethrow;
    }
    print("send an email");
  }
}

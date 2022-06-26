import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/pages/forgot_password.dart';
import 'package:pgee/services/firebase_auth_service.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool VisiblePassword = false;
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Влизане", style: Theme.of(context).textTheme.headline2),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Емайл",
              ),
              onChanged: (value) => {
                email.text = value,
              },
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: !VisiblePassword,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Парола",
                suffixIcon: IconButton(
                  icon: Icon(
                    VisiblePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      VisiblePassword = !VisiblePassword;
                      print("VisiblePassword: $VisiblePassword");
                    });
                  },
                ),
              ),
              onChanged: (value) => {
                password.text = value,
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Влез"),
              ),
              onPressed: () {
                FirebaseAuthService.signIn(context, email.text, password.text);
              },
            ),
            TextButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Забравена парола?"),
              ),
              onPressed: () {
                showDialog(
                    context: context, builder: (context) => ForgotPassword());
              },
            ),
          ],
        ),
      )),
    );
  }
}

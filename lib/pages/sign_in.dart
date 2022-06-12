import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/pages/forgot_password.dart';
import 'package:pgee/services/firebase_service.dart';

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
              // textAlign: TextAlign.center,
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
                // border: const OutlineInputBorder(),
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
                signIn();
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

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    print("sign");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
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
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
      rethrow;
    }

    bool UserAdmin = await FirebaseService.isAdmin();
    print("signIn: ${FirebaseAuth.instance.currentUser?.email}");
    Navigator.pushReplacementNamed(context, "/home");
  }
}

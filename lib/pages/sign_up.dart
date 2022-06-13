import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/services/firebase_service.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var selectedRole = "";
  var roleText = "Моля изберете роля";

  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController classNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Регистрация"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Емайл",
                ),
                controller: email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: "Име",
                ),
                controller: fullName,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    roleText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  PopupMenuButton(
                    elevation: 20,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text("Ученик"),
                        onTap: () {
                          setState(() {
                            selectedRole = "student";
                            roleText = "Ученик";
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: const Text("Учител"),
                        onTap: () {
                          setState(() {
                            selectedRole = "teacher";
                            roleText = "Учител";
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: const Text("Админ"),
                        onTap: () {
                          setState(() {
                            selectedRole = "admin";
                            roleText = "Админ";
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
              // If Student is selected, show the following fields
              SizedBox(height: 20),
              Visibility(
                visible: selectedRole == "student" || selectedRole == "teacher",
                child: Column(
                  children: [
                    TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Клас",
                      ),
                      controller: classNumber,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  FirebaseService.signUp(
                      context, email.text, fullName.text, selectedRole);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Регистрация",
                      style: Theme.of(context).textTheme.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

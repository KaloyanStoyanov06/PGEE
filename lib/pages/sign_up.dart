import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var selectedRole = "";
  var RoleText = "Моля изберете роля";

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
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                autofocus: false,
                decoration: InputDecoration(
                  labelText: "Емайл",
                ),
              ),
              SizedBox(height: 20),
              TextField(
                autofocus: false,
                decoration: InputDecoration(
                  labelText: "Име",
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    RoleText,
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
                        child: Text("Ученик"),
                        onTap: () {
                          setState(() {
                            selectedRole = "student";
                            RoleText = "Ученик";
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Учител"),
                        onTap: () {
                          setState(() {
                            selectedRole = "teacher";
                            RoleText = "Учител";
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Админ"),
                        onTap: () {
                          setState(() {
                            selectedRole = "admin";
                            RoleText = "Админ";
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Регистрация",
                      style: Theme.of(context).textTheme.button),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

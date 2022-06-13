import 'package:flutter/material.dart';
import 'package:pgee/services/firebase_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Регистрация"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey[700]!,
                      width: 1,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
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

                              // Lose focus to hide the keyboard
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                          ),
                          PopupMenuItem(
                            child: const Text("Учител"),
                            onTap: () {
                              setState(() {
                                selectedRole = "teacher";
                                roleText = "Учител";
                              });

                              // Lose focus to hide the keyboard
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                          ),
                          PopupMenuItem(
                            child: const Text("Админ"),
                            onTap: () {
                              setState(() {
                                selectedRole = "admin";
                                roleText = "Админ";
                              });

                              // Lose focus to hide the keyboard
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // If Student is selected, show the following fields
                const SizedBox(height: 20),
                Visibility(
                  visible:
                      selectedRole == "student" || selectedRole == "teacher",
                  child: Column(
                    children: [
                      TextField(
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelText: "Клас",
                        ),
                        controller: classNumber,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    FirebaseService.signUp(context, email.text, fullName.text,
                        selectedRole, classNumber.text);
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
      ),
    );
  }
}

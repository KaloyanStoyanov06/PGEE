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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController numberInClassController = TextEditingController();
  TextEditingController teachItemController = TextEditingController();
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Регистрация"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Име",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Емайл",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                              FocusScope.of(context).requestFocus(FocusNode());
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
                              FocusScope.of(context).requestFocus(FocusNode());
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
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
                        controller: classController,
                      ),
                      const SizedBox(height: 20),
                      if (selectedRole == "student")
                        TextField(
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Номер в класа",
                          ),
                          controller: numberInClassController,
                        ),
                      if (selectedRole == "teacher")
                        TextField(
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: "Предмет",
                          ),
                          controller: teachItemController,
                        ),
                    ],
                  ),
                ),
                // To make some space
                if (selectedRole == "student" || selectedRole == "teacher")
                  const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Checkbox(
                        value: isAdmin,
                        onChanged: (value) => setState(() {
                              isAdmin = value!;
                            })),
                    Text(
                      "Админ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => FirebaseService.signUp(
                      context,
                      emailController.text,
                      nameController.text,
                      selectedRole,
                      classController.text,
                      numberInClassController.text,
                      teachItemController.text,
                      isAdmin),
                  child: const Text("Запази промените"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

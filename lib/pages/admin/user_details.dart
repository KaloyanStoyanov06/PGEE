import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/services/firebase_service.dart';

class UserDetails extends StatefulWidget {
  UserDetails({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  Future<DocumentSnapshot> getData() async {
    DocumentReference doc =
        await FirebaseFirestore.instance.collection('users').doc(widget.uid);

    return doc.get().then((value) => value);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController numberInClassController = TextEditingController();
  String selectedRole = "";
  String roleText = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    readAndSetData();
    print(widget.uid);
  }

  void readAndSetData() async {
    DocumentSnapshot data = await getData();
    nameController.text = data['name'];
    emailController.text = data['email'];
    classController.text = data['class'];
    numberInClassController.text = data['numberInClass'].toString();

    setState(() {
      selectedRole = data['role'];

      if (selectedRole == "admin") {
        roleText = "Администратор";
      } else if (selectedRole == "teacher") {
        roleText = "Учител";
      } else if (selectedRole == "student") {
        roleText = "Ученик";
      }
    });
  }

  Widget DeleteDialog() {
    return AlertDialog(
      title: const Text("Сигурни ли сте?"),
      content:
          const Text("Сигурни ли сте, че искате да изтриете този потребител"),
      actions: [
        ElevatedButton(
          child: const Text("Да"),
          onPressed: () {
            FirebaseService.deleteUser(context, widget.uid);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          child: const Text("Не"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Модифициране на\nпотребител"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                  context: context, builder: (context) => DeleteDialog());
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
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
                    ],
                  ),
                ),
                // To make some space
                if (selectedRole == "student") const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => FirebaseService.updateUser(
                      context,
                      emailController.text,
                      nameController.text,
                      selectedRole,
                      classController.text,
                      numberInClassController.text,
                      widget.uid),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  String selectedRole = "";
  String roleText = "";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          nameController = TextEditingController(
              text:
                  "${snapshot.data!['firstName']} ${snapshot.data!['lastName']}");
          emailController =
              TextEditingController(text: snapshot.data!['email']);
          classController =
              TextEditingController(text: snapshot.data!['class']);
          selectedRole = snapshot.data!['role'].toString();
          roleText = "";

          switch (selectedRole) {
            case 'admin':
              roleText = 'Админ';
              break;
            case 'teacher':
              roleText = 'Учител';
              break;
            case 'student':
              roleText = 'Ученик';
              break;
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Модифициране на\nпотребител"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Име",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
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
              ],
            ),
          ),
        );
      },
    );
  }
}

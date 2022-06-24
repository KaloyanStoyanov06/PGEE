import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/components/role/admin_tile.dart';
import 'package:pgee/components/role/student_tile.dart';
import 'package:pgee/components/role/teacher_tile.dart';
import 'package:pgee/pages/admin/user_details.dart';

class ModUsersPage extends StatefulWidget {
  ModUsersPage({Key? key}) : super(key: key);

  @override
  State<ModUsersPage> createState() => _ModUsersPageState();
}

class _ModUsersPageState extends State<ModUsersPage> {
  var stream = FirebaseFirestore.instance
      .collection('users')
      .orderBy('role')
      .orderBy('name')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Потребители'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {},
          )
        ],
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text("Грешка\n" + snapshot.error.toString()));
          }

          return RefreshIndicator(
            onRefresh: () {
              showDialog(
                  context: context,
                  builder: (context) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ));

              setState(() {
                stream = const Stream.empty();
                stream = FirebaseFirestore.instance
                    .collection('users')
                    .orderBy('role')
                    .orderBy('name')
                    .snapshots();
              });
              Navigator.pop(context);
              return Future.value();
            },
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document =
                    snapshot.data?.docs[index] as DocumentSnapshot<Object?>;

                Widget child;

                if (document['role'] == 'student') {
                  child = StudentTile(
                    name: document['name'],
                    email: document['email'],
                    className: document['class'],
                    numberInClass: document['numberInClass'],
                    isAdmin: document['isAdmin'],
                  );
                } else if (document['role'] == 'teacher') {
                  child = TeacherTile(
                    email: document['email'],
                    name: document['name'],
                    className: document['class'],
                    teachItem: document['teachItem'],
                    isAdmin: document['isAdmin'],
                  );
                } else if (document['role'] == 'admin') {
                  child = AdminTile(name: document['name']);
                } else {
                  child = const Text("NOT RECOGNIZED");
                }

                return GestureDetector(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetails(uid: document.id),
                          ),
                        ),
                    child: Container(
                      // decoration: const BoxDecoration(
                      //   border: Border(
                      //     bottom: BorderSide(color: Colors.grey),
                      //   ),
                      // ),
                      child: child,
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}

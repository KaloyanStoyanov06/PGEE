import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pgee/components/user_list_tile.dart';
import 'package:pgee/pages/admin/user_details.dart';

class ModUsersPage extends StatefulWidget {
  ModUsersPage({Key? key}) : super(key: key);

  @override
  State<ModUsersPage> createState() => _ModUsersPageState();
}

class _ModUsersPageState extends State<ModUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modify Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetails(uid: document.id),
                  ),
                ),
                child: UserListTile(
                  firstName: document['firstName'],
                  lastName: document['lastName'],
                  email: document['email'],
                  classNumber: document['class'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

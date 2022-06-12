import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/components/admin_functions.dart';
import 'package:pgee/services/firebase_service.dart';

class DrawerComponent extends StatelessWidget {
  DrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.today),
            title: Text("Днес"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_view_day_rounded),
            title: Text("Утре"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: Icon(Icons.calendar_view_week_rounded),
            title: Text("Седмица"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          FutureBuilder(
            future: FirebaseService.isAdmin(),
            builder: (context, snapshot) {
              var isAdmin = snapshot.data.toString().toLowerCase() == 'true';
              if (isAdmin) {
                return AdminFunctions();
              }

              return Container();
            },
          ),
          Expanded(
            child: Container(),
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: Icon(Icons.settings),
            title: Text("Настройки"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/sign-in');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Излез"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/sign-in');
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

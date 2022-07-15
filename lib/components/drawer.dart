import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgee/components/admin_functions.dart';
import 'package:pgee/pages/settings.dart';
import 'package:pgee/services/firebase_auth_service.dart';

class DrawerComponent extends StatelessWidget {
  DrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      elevation: 20,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              child: Text(
                "ПГЕЕ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: const Icon(Icons.calendar_view_day_rounded),
            title: const Text("Утре"),
            onTap: () {
              HapticFeedback.heavyImpact();
              Navigator.pushNamed(context, '/tommorow');
            },
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: const Icon(Icons.note),
            title: const Text("Домашни"),
            onTap: () {
              HapticFeedback.heavyImpact();
              Navigator.pushNamed(context, '/homework');
            },
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: const Icon(Icons.school_rounded),
            title: const Text("Тестове"),
            onTap: () {
              HapticFeedback.heavyImpact();
              Navigator.pop(context);
            },
          ),
          FutureBuilder(
            future: FirebaseAuthService.isAdmin(),
            builder: (context, snapshot) {
              var isAdmin = snapshot.data.toString().toLowerCase() == 'true';
              Widget child = Container();
              if (isAdmin) {
                child = Column(
                  key: const ValueKey(1),
                  children: [
                    SizedBox(
                      height: 35,
                      child: Container(
                        width: 180,
                        decoration: BoxDecoration(
                          // bottom border
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[700]!,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Администратор",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                    AdminFunctions()
                  ],
                );
              }

              return AnimatedSwitcher(
                switchInCurve: Curves.easeInOutQuad,
                duration: const Duration(milliseconds: 500),
                child: child,
              );
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
              HapticFeedback.heavyImpact();
              Navigator.pushNamed(context, "/settings");
            },
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: Icon(Icons.logout),
            title: Text("Излез"),
            onTap: () {
              HapticFeedback.heavyImpact();
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgee/components/drawer.dart';
import 'package:pgee/components/navigation.dart';
import 'package:pgee/pages/programs/today.dart';
import 'package:pgee/pages/programs/week.dart';
import 'package:pgee/pages/sign_in.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var index = 0;

  var items = [
    NavigationDestination(icon: Icon(Icons.today), label: "Днес"),
    NavigationDestination(
        icon: Icon(Icons.calendar_view_week), label: "Седмична програма"),
  ];

  List<Widget> pages = [TodayPage(), WeekPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(),
      appBar: AppBar(
        title: const Text(""),
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (index) => {
          setState(() => {this.index = index})
        },
        destinations: items,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            enableDrag: true,
            builder: (context) {
              return BottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                onClosing: () {},
                builder: (context) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.note_add),
                        title: Text("Домашна"),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.school_rounded),
                        title: Text("Тест"),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );

          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text("Добавяне"),
          //       content: SingleChildScrollView(
          //         child: ListBody(
          //           children: [
          //             ListTile(
          //               leading: Icon(Icons.note_add),
          //               title: Text("Домашна"),
          //               onTap: () {
          //                 Navigator.pop(context);
          //               },
          //             ),
          //             SizedBox(height: 10),
          //             ListTile(
          //               leading: Icon(Icons.school_rounded),
          //               title: Text("Тест"),
          //               onTap: () {
          //                 Navigator.pop(context);
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
        child: Icon(Icons.add),
        isExtended: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

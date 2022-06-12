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
    );
  }
}

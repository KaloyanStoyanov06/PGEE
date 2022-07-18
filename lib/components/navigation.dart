import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigationBarBottom extends StatefulWidget {
  NavigationBarBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBarBottom> createState() => _NavigationBarBottomState();
}

class _NavigationBarBottomState extends State<NavigationBarBottom> {
  var index = 0;

  var items = const [
    NavigationDestination(
      icon: Icon(Icons.today),
      label: "Днес",
    ),
    NavigationDestination(
      icon: Icon(Icons.calendar_view_week),
      label: "Седмична програма",
    ),
    NavigationDestination(
      icon: Icon(Icons.today),
      label: "Днес",
    ),
    NavigationDestination(
      icon: Icon(Icons.calendar_view_week),
      label: "Седмична програма",
    ),
    NavigationDestination(
      icon: Icon(Icons.today),
      label: "Днес",
    ),
    NavigationDestination(
      icon: Icon(Icons.calendar_view_week),
      label: "Седмична програма",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      animationDuration: Duration(milliseconds: 5000),
      selectedIndex: index,
      onDestinationSelected: (index) async {
        HapticFeedback.heavyImpact();
        setState(() => {this.index = index});
      },
      destinations: items,
    );
  }
}

import 'package:flutter/material.dart';

class QuickAddButton extends StatefulWidget {
  QuickAddButton({Key? key}) : super(key: key);

  @override
  State<QuickAddButton> createState() => _QuickAddButtonState();
}

class _QuickAddButtonState extends State<QuickAddButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          enableDrag: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.note_add),
                  title: Text("Домашна"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.school_rounded),
                  title: Text("Тест"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        );
      },
      child: Icon(Icons.add),
      isExtended: true,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }
}

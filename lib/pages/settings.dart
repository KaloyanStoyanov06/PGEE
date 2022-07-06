import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkTheme = true;

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'kaloyangfx@gmail.com',
    query:
        'subject=Предложения за програмата на ПГЕЕ', //add subject and body here
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Настройки"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("???????", style: Theme.of(context).textTheme.headline6),
                Switch.adaptive(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: darkTheme,
                  onChanged: (value) {
                    setState(() {
                      darkTheme = value;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
                launchUrl(emailLaunchUri);
              },
              icon: const Icon(Icons.email_rounded),
              label: const Text("Изпрати ни емайл за предложения"),
            ),
          ],
        ),
      ),
    );
  }
}

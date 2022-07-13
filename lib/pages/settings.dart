import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var prefs = SharedPreferences.getInstance();
  int themeValue = 1;

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'kaloyangfx@gmail.com',
    query:
        'subject=Предложения за програмата на ПГЕЕ', //add subject and body here
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prefs,
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var storage = snapshot.data!;

        if (snapshot.hasData) {
          themeValue = storage.getInt("themeValue") ?? 1;
        }

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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Тема",
                      style: Theme.of(context).textTheme.headline6),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Aвтоматична тема",
                        style: Theme.of(context).textTheme.subtitle1),
                    Radio(
                      value: 1,
                      groupValue: themeValue,
                      onChanged: (val) {
                        setState(() {
                          themeValue = val as int;
                          storage.setInt("themeValue", themeValue);
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Тъмна тема",
                        style: Theme.of(context).textTheme.subtitle1),
                    Radio(
                      value: 2,
                      groupValue: themeValue,
                      onChanged: (val) {
                        setState(() {
                          themeValue = val as int;
                          storage.setInt("themeValue", themeValue);
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Светла тема",
                        style: Theme.of(context).textTheme.subtitle1),
                    Radio(
                      value: 3,
                      groupValue: themeValue,
                      onChanged: (val) {
                        setState(() {
                          themeValue = val as int;
                          storage.setInt("themeValue", themeValue);
                        });
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    launchUrl(emailLaunchUri);
                  },
                  icon: const Icon(Icons.email_rounded),
                  label: const Text("Изпрати ни емайл за предложения"),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

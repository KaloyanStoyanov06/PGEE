import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateHomeworkPage extends StatefulWidget {
  CreateHomeworkPage({Key? key}) : super(key: key);

  @override
  State<CreateHomeworkPage> createState() => _CreateHomeworkPageState();
}

class _CreateHomeworkPageState extends State<CreateHomeworkPage> {
  Widget Space() => const SizedBox(height: 20);

  var title = TextEditingController(text: "");
  var description = TextEditingController(text: "");
  var date = DateTime.now();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title:
                Text("Сигурни ли сте, че искате да затворите тази страница?"),
            actions: [
              ElevatedButton(
                child: Text("Да"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text("Не"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Добави домашна'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      labelText: 'Предмет',
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Попълнете полето';
                      }
                      return null;
                    },
                  ),
                  Space(),
                  TextFormField(
                    controller: description,
                    decoration: InputDecoration(
                      labelText: 'Описание',
                      prefixIcon: Icon(Icons.description),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Попълнете полето';
                      }
                      return null;
                    },
                  ),
                  Space(),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: Text('${date.day}.${date.month}.${date.year}'),
                    subtitle: const Text('Дата на домашната'),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025),
                      ).then((date) {
                        if (date != null) {
                          print(date);
                          setState(() {
                            this.date = date;
                          });
                        }
                      });
                    },
                  ),
                  Space(),
                  ElevatedButton(
                    child: const Text('Добави'),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Попълнете полетата'),
                            actions: [
                              ElevatedButton(
                                child: Text('Ок'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      } else {
                        HapticFeedback.mediumImpact();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

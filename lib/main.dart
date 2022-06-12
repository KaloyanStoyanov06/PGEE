import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pgee/firebase_options.dart';
import 'package:pgee/pages/home.dart';
import 'package:pgee/pages/sign_in.dart';
import 'package:pgee/pages/sign_up.dart';
import 'package:pgee/pages/switch.dart';
import 'package:pgee/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var brightness =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
      statusBarIconBrightness: brightness,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: SwitchPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => SignUpPage()
      },
    );
  }
}

import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pgee/firebase_options.dart';
import 'package:pgee/pages/admin/users.dart';
import 'package:pgee/pages/home.dart';
import 'package:pgee/pages/programs/tommorow.dart';
import 'package:pgee/pages/settings.dart';
import 'package:pgee/pages/auth/sign_in.dart';
import 'package:pgee/pages/admin/sign_up.dart';
import 'package:pgee/pages/auth/auth_redirect.dart';
import 'package:pgee/pages/student/homework/create_homework.dart';
import 'package:pgee/pages/student/homework/homework.dart';
import 'package:pgee/services/style_ui_service.dart';
import 'package:pgee/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

CustomColors lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
CustomColors darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    //TODO: Implement a theme switcher or look for one.

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    StyleUiService.ApplyUI();

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          // On Android S+ devices, use the provided dynamic color scheme.
          // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
          lightColorScheme = lightDynamic.harmonized();
          // (Optional) If applicable, harmonize custom colors.
          lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

          // Repeat for the dark color scheme.
          darkColorScheme = darkDynamic.harmonized();
          darkColorScheme =
              darkColorScheme.copyWith(secondary: Colors.deepPurple);
          darkCustomColors = darkCustomColors.harmonized(darkColorScheme);
        } else {
          // Otherwise, use fallback schemes.
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PGEE',
          theme: Themes.lightTheme.copyWith(
            colorScheme: lightColorScheme,
            extensions: [lightCustomColors],
          ),
          darkTheme: Themes.darkTheme.copyWith(
            colorScheme: darkColorScheme,
            extensions: [darkCustomColors],
          ),
          home: AuthRedirect(),
          routes: {
            '/home': (context) => HomePage(),
            '/sign-in': (context) => SignInPage(),
            '/sign-up': (context) => SignUpPage(),
            '/settings': (context) => SettingsPage(),
            '/mod-users': (context) => ModUsersPage(),
            '/tommorow': (context) => TommorowPage(),
            '/homework': (context) => HomeworkPage(),
            '/homework/create': (context) => CreateHomeworkPage(),
          },
          themeMode: _themeMode,
        );
      },
    );
  }
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
  }
}

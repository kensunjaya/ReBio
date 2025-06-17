import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rebio/components/BottomNavbar.dart';
import 'package:rebio/pages/FillToDo.dart';
import 'package:rebio/pages/history.dart';
import 'package:rebio/pages/home.dart';
import 'package:rebio/pages/login.dart';
import 'package:rebio/pages/recommendation.dart';
import 'package:rebio/pages/register.dart';
import 'package:rebio/theme/constants.dart';
import 'package:rebio/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ReBio());
}

class ReBio extends StatelessWidget {
  const ReBio({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'ReBio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primary,
          selectionColor: primary.withValues(alpha: 0.5),
          selectionHandleColor: primary,
        ),
      ),
      home: WidgetTree(),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/recommendation': (context) => Recommendation(),
        '/filltodo': (context) => Filltodo(), // Placeholder for filltodo page
        '/mainscreen': (context) => MainScreen(),
        '/history': (context) => HistoryPage(),
      },
    );
  }
}

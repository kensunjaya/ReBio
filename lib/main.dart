import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rebio/pages/home.dart';
import 'package:rebio/pages/login.dart';
import 'package:rebio/pages/register.dart';
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
      ),
      home: WidgetTree(),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}

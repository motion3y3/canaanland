import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sweat_kick/view/physicalMeetings.dart';
import 'package:sweat_kick/view/login.dart';
import 'package:sweat_kick/view/onlineMeetings.dart';
import 'package:sweat_kick/view/admin.dart';
import 'package:sweat_kick/view/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const ChurchApp());
}

class ChurchApp extends StatelessWidget {
  const ChurchApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginScreen(),
        'CreateNewAccount': (context) => LoginScreen(),
      },
    );
  }
}

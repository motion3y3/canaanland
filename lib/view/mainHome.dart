import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweat_kick/view/physicalMeetings.dart';
import 'package:sweat_kick/view/onlineMeetings.dart';
import 'package:sweat_kick/view/admin.dart';
import 'package:sweat_kick/view/readings/lifestudy.dart';
import 'package:sweat_kick/view/settings.dart';

void main() {
  runApp(const MyApp());
}

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Canaan Land'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isAdmin = false;
  final List<Widget> _pages = [
    const HomePage(),
    Page1(),
    Page3(),
    const LifeStudyPage(),
  ];
  List<BottomNavigationBarItem> footerItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.video_call_outlined),
      label: 'Online Meeing',
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined), label: 'Settings'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.menu_book), label: 'Reading'),
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context)
                .colorScheme
                .inversePrimary, // Set the background color to transparent
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            fixedColor: Colors.black,
            showUnselectedLabels: true,
            items: footerItems,
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}

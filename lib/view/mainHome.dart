import 'package:flutter/material.dart';
import 'package:sweat_kick/view/homePage.dart';
import 'package:sweat_kick/view/page1.dart';
import 'package:sweat_kick/view/page2.dart';
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
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    Page1(),
    UserListScreen(),
    Page3()
  ];

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
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.video_call_outlined),
                  label: 'Online Meeing',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.pageview), label: 'Page 2'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    label: 'Settings'),
              ]),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}

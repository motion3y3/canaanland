import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweat_kick/view/readings/lifestudy.dart';
import 'package:sweat_kick/view/readings/truthpursue.dart';

class ReadingMaterialScreen extends StatefulWidget {
  @override
  _ReadingMaterialScreenState createState() => _ReadingMaterialScreenState();
}

class _ReadingMaterialScreenState extends State<ReadingMaterialScreen> {

  final List<String> items = [
    "Life Study",
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reading Materials 书报追求'),
        ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Life Study'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LifeStudyPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Truth Pursue'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TruthPursuePage(),
                ),
              );
            },
          ),
          // Add more ListTile options for other pages as needed
        ],
      ),
    );
  }
}

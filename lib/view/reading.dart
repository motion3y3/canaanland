import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sweat_kick/view/readings/lifestudy.dart';
import 'package:sweat_kick/view/readings/truth-pursue/truthPursueList.dart';

class ReadingMaterialScreen extends StatefulWidget {
  @override
  _ReadingMaterialScreenState createState() => _ReadingMaterialScreenState();
}

class _ReadingMaterialScreenState extends State<ReadingMaterialScreen> {
  final List<String> items = [
    "Life Study",
  ];

  List<PlatformFile> selectedFiles = [];
  bool isUploading = false;

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
            title: Text('Life Study 生命读经'),
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
            title: Text('Truth Pursue 真理追求'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TruthPursueListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

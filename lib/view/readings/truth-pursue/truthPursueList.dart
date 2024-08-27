import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../../widgets/uploadPopup.dart';
import 'truthPursueViewer.dart';

class TruthPursueListPage extends StatefulWidget {
  @override
  _TruthPursueListPageState createState() => _TruthPursueListPageState();
}

class _TruthPursueListPageState extends State<TruthPursueListPage> {
  List<Map<String, String>> files = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFiles();
  }

  Future<void> fetchFiles() async {
    List<Map<String, String>> tempFiles = [];
    final storageRef = FirebaseStorage.instance.ref().child('truthPursue');
    final ListResult result = await storageRef.listAll();

    for (var ref in result.items) {
      final String url = await ref.getDownloadURL();
      final String name = ref.name;

      tempFiles.add({
        'name': name,
        'url': url,
      });
    }

    setState(() {
      files = tempFiles;
      isLoading = false;
    });
  }

  Future<void> openFile(BuildContext context, String url) async {
    final file = await _downloadFile(url);
    if (file != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TruthPursuePage(filePath: file.path),
        ),
      );
    }
  }

  Future<File?> _downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/temp.pdf');

        await file.writeAsBytes(response.bodyBytes);
        return file;
      } else {
        print('Error downloading file: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UploadPopup(
          onFilesSelected: (selectedFiles) async {
            setState(() {
              isLoading = true;
            });

            try {
              for (var file in selectedFiles) {
                String fileName = file.name;
                DateTime uploadDate = DateTime.now();

                // Convert the path to File type
                File fileToUpload = File(file.path!);

                // Upload to Firebase Storage
                await FirebaseStorage.instance
                    .ref('truthPursue/$fileName')
                    .putFile(fileToUpload);

                // Save metadata to Firestore
                await FirebaseFirestore.instance.collection('truthPursue').add({
                  'fileName': fileName,
                  'date': uploadDate,
                });
              }

              await fetchFiles(); // Refresh the file list after uploading
            } catch (e) {
              print('Error uploading files: $e');
            } finally {
              setState(() {
                isLoading = false;
              });
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Truth Pursue'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(files[index]['name']!),
            onTap: () => openFile(context, files[index]['url']!),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _showPopup,
          child: Text('Upload PDF'),
        ),
      ),
    );
  }
}

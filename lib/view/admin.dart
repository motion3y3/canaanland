import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // List to store user data
  List<UserInfo> users = [];

  @override
  void initState() {
    super.initState();
    _fetchUserList();
  }

  Future<void> _fetchUserList() async {
    // Fetch the list of users from Firebase Authentication
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final List<UserInfo> userList = currentUser.providerData;

      setState(() {
        users = userList;
      });
    }
  }
  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _textController = TextEditingController();

        return AlertDialog(
          title: Text('Enter Details'),
          content: Container(
            height: 300,
            child: TextField(
              controller: _textController,
              maxLines: null,
              minLines: null/**/,
              expands: true,
              decoration: InputDecoration(
                hintText: 'Enter something',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle save action
                print('Saved: ${_textController.text}');
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                // Handle cancel action
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text('User ID: ${user.uid}'),
                  subtitle: Text('Email: ${user.email}'),
                  // Add more user data as needed
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _showPopup,
              child: Text('Open Popup'),
            ),
          ),
        ],
      ),
    );
  }
}

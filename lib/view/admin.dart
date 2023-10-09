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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
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
    );
  }
}

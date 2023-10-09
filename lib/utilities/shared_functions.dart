import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final currentUser = _auth.currentUser;
final userEmail = currentUser?.email;

// Create a DateFormat instance for the desired date format
DateFormat dateFormat = DateFormat('yyyy-MM-dd');

// Get the current date as a formatted string
String currentDateFormatted = dateFormat.format(DateTime.now());

// Define the collection and document path using date and user email
String collectionPath = 'Attendance';
String documentPath = '${currentDateFormatted}_${userEmail!}';

Future<bool> getAttendanceData(String meetingType) async {
  try {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where('date', isEqualTo: currentDateFormatted)
        .where('email', isEqualTo: userEmail)
        .get();

    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      // Loop through the documents and access their fields
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Now you can access individual fields from 'data'
        bool isPsrp = data['psrp'];
        bool isLifestudy = data['lifestudy'];
        bool isLordsDay = data['lordsday'];
        bool isProphesying = data['prophesying'];
        bool isCellGroup = data['cellgroup'];
        bool isSheperding = data['sheperding'];
        // ... and so on

        print(isPsrp);

        // You can process or store the data as needed
      }
    } else {
      // No documents matched the query
    }
  } catch (e) {
    // Handle errors here
    print('Error: $e');
    return false;
  }
  return true;
}

Future<bool> addAttendanceData(String meetingType) async {
  bool complete = false;

  try {
    // Check if the document already exists
    final DocumentReference docRef =
        firestore.collection(collectionPath).doc(documentPath);
    final DocumentSnapshot docSnapshot = await docRef.get();

    QuerySnapshot querySnapshot = await firestore
        .collection('attendance')
        .where('date', isEqualTo: currentDateFormatted)
        .where('email', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      if (meetingType == 'PSRP 祷言背讲') {
        await docSnapshot.reference.update({
          'psrp': true,
        });
      }
      if (meetingType == 'LifeStudy 生命读经追求') {
        await docSnapshot.reference.update({
          'lifestudy': true,
        });
      }
      if (meetingType == "Lord's Table Meeting 祷言背讲") {
        await docSnapshot.reference.update({
          'lordsday': true,
        });
      }
      if (meetingType == 'Prophesying 申言') {
        await docSnapshot.reference.update({
          'prophesying': true,
        });
      }
      if (meetingType == 'Shepherding 牧养') {
        await docSnapshot.reference.update({
          'sheperding': true,
        });
      }
      if (meetingType == 'Group Meeting 小排') {
        await docSnapshot.reference.update({
          'cellgroup': true,
        });
      }
      print("Successfully record attendance");
      complete = true;
    } else {
      await firestore.collection('attendance').add({
        'date': currentDateFormatted,
        'email': userEmail,
        if (meetingType == 'PSRP 祷言背讲') 'psrp': true,
        if (meetingType != 'PSRP 祷言背讲') 'lifestudy': true,
      });
      print("Successfully record attendance");
      complete = true;
    }
  } catch (e) {
    print('Error adding attendance data: $e');
  }

  return complete;
}

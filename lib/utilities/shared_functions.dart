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

Future<bool> addAttendanceData(String meetingType, bool currAttendance) async {
  bool complete = false;
  bool newAttendance = !currAttendance;

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
          'psrp': newAttendance,
        });
      }
      if (meetingType == 'LifeStudy 生命读经追求') {
        await docSnapshot.reference.update({
          'lifestudy': newAttendance,
        });
      }
      if (meetingType == "Lord's Table Meeting 主日聚会") {
        await docSnapshot.reference.update({
          'lordsday': newAttendance,
        });
      }
      if (meetingType == 'Prophesying 申言') {
        await docSnapshot.reference.update({
          'prophesying': newAttendance,
        });
      }
      if (meetingType == 'Shepherding 牧养') {
        await docSnapshot.reference.update({
          'sheperding': newAttendance,
        });
      }
      if (meetingType == 'Group Meeting 小排') {
        await docSnapshot.reference.update({
          'cellgroup': newAttendance,
        });
      }
      print("Successfully record attendance");
      complete = true;
    } else {
      await firestore.collection('attendance').add({
        'date': currentDateFormatted,
        'email': userEmail,
        if (meetingType == 'PSRP 祷言背讲') 'psrp': newAttendance,
        if (meetingType != 'PSRP 祷言背讲') 'lifestudy': newAttendance,
      });
      print("Successfully record attendance");
      complete = true;
    }
  } catch (e) {
    print('Error adding attendance data: $e');
  }

  return complete;
}

Future<bool> getAttendanceData(String meetingType) async {
  try {
    QuerySnapshot querySnapshot = await firestore
        .collection('attendance')
        .where('date', isEqualTo: currentDateFormatted)
        .where('email',
            isEqualTo: userEmail) // Assuming you have userEmail defined
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      // Depending on the meeting type, fetch the corresponding data
      bool isRecorded = false;
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

      if (meetingType == 'PSRP 祷言背讲') {
        isRecorded = data['psrp'] ?? false;
      } else if (meetingType == 'LifeStudy 生命读经追求') {
        isRecorded = data['lifestudy'] ?? false;
      } else if (meetingType == "Lord's Table Meeting 主日聚会") {
        isRecorded = data['lordsday'] ?? false;
      } else if (meetingType == 'Prophesying 申言') {
        isRecorded = data['prophesying'] ?? false;
      } else if (meetingType == 'Shepherding 牧养') {
        isRecorded = data['sheperding'] ?? false;
      } else if (meetingType == 'Group Meeting 小排') {
        isRecorded = data['cellgroup'] ?? false;
      }

      // You can return isRecorded or use it as needed
      return isRecorded;
    }
  } catch (e) {
    print('Error getting attendance data: $e');
  }

  // Return false if data retrieval failed
  return false;
}

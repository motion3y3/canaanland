
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utilities/shared_functions.dart';

class Meeting {
  final String title;
  final String? time;
  final String? day;
  final String? data;

  Meeting(this.title, this.time, this.day, this.data);
}

class OnlineMeetingPage extends StatefulWidget{
  OnlineMeetingPage({Key? key}) : super(key: key);

  @override
  MyPage1 createState() => MyPage1();
}
class MyPage1 extends State<OnlineMeetingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<bool> _selectedDays = List<bool>.filled(7, false);
  TimeOfDay? _selectedTime;

  final List<String> _daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime;
      });

      // Add logic to save the reminder here
      print('Reminder set for days: ${_selectedDays.asMap().entries.where((entry) => entry.value).map((entry) => _daysOfWeek[entry.key]).join(', ')} at ${selectedTime.format(context)}');
    }
  }
  final List<Meeting> allMeetings = [
    Meeting('PSRP 祷言背讲', '8:30 PM', "Tuesday 周二",
        "https://us02web.zoom.us/j/88634421369?pwd=TUZ6ZWJpZ2lrMU4zbDlDcmpkSE96QT09"),
    Meeting('LS Daily Pursue 每日共读', '10.00 PM', "Daily 每天",
        "https://us02web.zoom.us/j/86022726417?pwd=cU1BWTRvSm5JRWwrRi9LZ2E0SXY2Zz09"),
    Meeting("Lord's Table Meeting 主日聚会", '10:00 AM', "Lord's Day 主日", null),
    Meeting('Prophesying 申言', null, "Lord's Day 主日", null),
    Meeting('Shepherding 牧养', null, null, null),
    Meeting('Group Meeting 小排', '7.00 PM', "Saturday 周六", null),
  ];

  void _showDayTimePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Reminder'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: _daysOfWeek.asMap().entries.map((entry) {
                      int index = entry.key;
                      String day = entry.value;
                      return CheckboxListTile(
                        title: Text(day),
                        value: _selectedDays[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedDays[index] = value ?? false;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _selectTime(context);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Select Time'),
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_selectedDays.contains(true) && _selectedTime != null) {
                  print('Reminder set for days: ${_selectedDays.asMap().entries.where((entry) => entry.value).map((entry) => _daysOfWeek[entry.key]).join(', ')} at ${_selectedTime!.format(context)}');
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  getMeetingCard(Meeting meetingType) {
    if (meetingType.data != null) {
      // Display card with join button for online meetings
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meetingType.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Time 时间: ${meetingType.time}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Day 周期: ${meetingType.day}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Handle join button tap here
                        final String? meetingUrl = meetingType.data;
                        final Uri meetingLinkToParse = Uri.parse(meetingUrl!);
                        addAttendanceData(meetingType.title, false);

                        if (await canLaunchUrl(meetingLinkToParse)) {
                          // Launch the URL
                          await launchUrl(meetingLinkToParse);
                        }
                      },
                      child: const Text('Join'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _showDayTimePickerDialog(context);
                      },
                      child: const Text('Reminder'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

    }

    // else {
    //   // Display different card style for physical meetings
    //   switch (meetingType.title) {
    //     case "Lord's Table Meeting 主日聚会":
    //       return LordsDayMeetingCard(
    //           title: meetingType.title,
    //           time: meetingType.time,
    //           day: meetingType.day);
    //     case "Prophesying 申言":
    //       return ProphesyingCard(
    //           title: meetingType.title,
    //           time: meetingType.time,
    //           day: meetingType.day);
    //     case "Shepherding 牧养":
    //       return SheperdingCard(
    //           title: meetingType.title,
    //           time: meetingType.time,
    //           day: meetingType.day);
    //     case "Group Meeting 小排":
    //       return GroupMeetingCard(
    //           title: meetingType.title,
    //           time: meetingType.time,
    //           day: meetingType.day);
    //     default:
    //       return Container(); // Handle other cases or return an empty container
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: allMeetings.length,
        itemBuilder: (context, index) {
          return getMeetingCard(allMeetings[index]);
        },
      ),
    );
  }
}

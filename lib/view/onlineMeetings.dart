
import 'package:flutter/material.dart';
import 'package:sweat_kick/view/meetingElem/lordsday.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utilities/shared_functions.dart';
import 'meetingElem/groupMeeting.dart';
import 'meetingElem/prophesying.dart';
import 'meetingElem/sheperding.dart';

class Meeting {
  final String title;
  final String? time;
  final String? day;
  final String? data;

  Meeting(this.title, this.time, this.day, this.data);
}
class Page1 extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<Meeting> allMeetings = [
    Meeting('PSRP 祷言背讲', '8:30 PM', "Tuesday 周二",
        "https://us02web.zoom.us/j/88634421369?pwd=TUZ6ZWJpZ2lrMU4zbDlDcmpkSE96QT09"),
    Meeting('LifeStudy 生命读经追求', '8.30 PM', "Thursday 周四",
        "https://us02web.zoom.us/j/86022726417?pwd=cU1BWTRvSm5JRWwrRi9LZ2E0SXY2Zz09"),
    Meeting("Lord's Table Meeting 主日聚会", '10:00 AM', "Lord's Day 主日", null),
    Meeting('Prophesying 申言', null, "Lord's Day 主日", null),
    Meeting('Shepherding 牧养', null, null, null),
    Meeting('Group Meeting 小排', '7.00 PM', "Saturday 周六", null),
  ];

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time 时间: ${meetingType.time}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Handle join button tap here
                        final String? meetingUrl = meetingType.data;
                        final Uri meetingLinkToParse =
                        Uri.parse(meetingUrl!);
                        addAttendanceData(meetingType.title, false);

                        if (await canLaunchUrl(meetingLinkToParse)) {
                          // Launch the URL
                          await launchUrl(meetingLinkToParse);
                        }
                      },
                      child: const Text('Join'),
                    ),
                  ],
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
        ),
      );
    } else {
      // Display different card style for physical meetings
      switch (meetingType.title) {
        case "Lord's Table Meeting 主日聚会":
          return LordsDayMeetingCard(
              title: meetingType.title,
              time: meetingType.time,
              day: meetingType.day);
        case "Prophesying 申言":
          return ProphesyingCard(
              title: meetingType.title,
              time: meetingType.time,
              day: meetingType.day);
        case "Shepherding 牧养":
          return SheperdingCard(
              title: meetingType.title,
              time: meetingType.time,
              day: meetingType.day);
        case "Group Meeting 小排":
          return GroupMeetingCard(
              title: meetingType.title,
              time: meetingType.time,
              day: meetingType.day);
        default:
          return Container(); // Handle other cases or return an empty container
      }
    }
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

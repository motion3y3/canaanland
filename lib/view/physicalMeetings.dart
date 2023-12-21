import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sweat_kick/utilities/shared_functions.dart';
import 'package:sweat_kick/view/meetingElem/groupMeeting.dart';
import 'package:sweat_kick/view/meetingElem/lordsday.dart';
import 'package:sweat_kick/view/meetingElem/prophesying.dart';
import 'package:sweat_kick/view/meetingElem/sheperding.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class Meeting {
  final String title;
  final String? time;
  final String? day;

  Meeting(this.title, this.time, this.day);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final List<Meeting> meetings = [
    Meeting("Lord's Table 主日聚会", '10:00 AM', "Lord's Day 主日"),
    Meeting('Prophesying 申言', null, "Lord's Day 主日"),
    Meeting('Shepherding 牧养', null, null),
    Meeting('Group Meeting 小排', '7.00 PM', "Saturday 周六")
  ];

  getMeetingCard(Meeting meetingType) {
    switch (meetingType.title) {
      case "Lord's Table 主日聚会":
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Attendance Table 操练表',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: meetings.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: getMeetingCard(meetings[index]));
          },
        ));
  }
}

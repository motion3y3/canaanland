// In home_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Meeting {
  final String title;
  final String time;
  final String day;
  final String data;

  Meeting(this.title, this.time, this.day, this.data);
}

class Page1 extends StatelessWidget {
  @override
  final List<Meeting> meetings = [
    Meeting('PSRP 祷言背讲', '8:30 PM', "Tuesday 周二",
        "https://us02web.zoom.us/j/88634421369?pwd=TUZ6ZWJpZ2lrMU4zbDlDcmpkSE96QT09"),
    Meeting('LifeStudy 生命读经追求', '8.30 PM', "Thursday 周四",
        "https://us02web.zoom.us/j/86022726417?pwd=cU1BWTRvSm5JRWwrRi9LZ2E0SXY2Zz09")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Meetings 线上聚会'),
      ),
      body: ListView.builder(
        itemCount: meetings.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meetings[index].title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Time 时间: ${meetings[index].time}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Day 周期: ${meetings[index].day}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Handle join button tap here
                            final String meetingUrl = meetings[index].data;
                            final Uri meetingLinkToParse =
                                Uri.parse(meetingUrl);

                            if (await canLaunchUrl(meetingLinkToParse)) {
                              // Launch the URL
                              await launchUrl(meetingLinkToParse);
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                        "Could not launch the meeting URL."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text('Join'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Similar code for Page1, Page2, Page3, and Page4

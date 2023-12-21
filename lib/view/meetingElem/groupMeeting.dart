import 'package:flutter/material.dart';

import '../../utilities/shared_functions.dart';

class GroupMeetingCard extends StatefulWidget {
  final String title;
  final String? time;
  final String? day;

  const GroupMeetingCard({
    Key? key,
    required this.title,
    this.time,
    this.day,
  }) : super(key: key);

  @override
  _GroupMeetingCardState createState() => _GroupMeetingCardState();
}

class _GroupMeetingCardState extends State<GroupMeetingCard> {
  bool isRecorded = false;
  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    bool result = await getAttendanceData(widget.title);
    setState(() {
      isRecorded = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time 时间: ${widget.time}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool done =
                        await addAttendanceData(widget.title, isRecorded);
                    if (done) {
                      setState(() {
                        isRecorded = !isRecorded;
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isRecorded ? Colors.green : Colors.red,
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                        color: isRecorded
                            ? Colors.green
                            : Colors.redAccent, // Border color
                        width: 4.0, // Border width
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isRecorded ? Icons.check : Icons.close,
                          color: Colors.white),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        isRecorded ? 'Recorded' : 'Record',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Day 周期: ${widget.day}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

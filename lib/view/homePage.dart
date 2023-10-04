import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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

class DropdownOption {
  final String value;
  final String display;

  DropdownOption(this.value, this.display);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController? webViewController;
  String extractedText = '';

  List<String> daysOfWeek = [
    'Monday 周一',
    'Tuesday 周二',
    'Wednesday 周三',
    'Thursday 周四',
    'Friday 周五',
    'Saturday 周六',
  ];

  List<DropdownOption> testamentVersion = [
    DropdownOption('ot', 'Old Testament'),
    DropdownOption('nt', 'New Testament'),
  ];
  DropdownOption selectedVersion = DropdownOption('ot', 'Old Testament');
  String selectedDay2 = 'Monday 周一';
  String selectedDay3 = 'Monday 周一';

  @override
  void initState() {
    super.initState();
    loadUrlAndExtractText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // DropdownButton<DropdownOption>(
                //   value: selectedVersion,
                //   onChanged: (newValue) {
                //     setState(() {
                //       selectedVersion = newValue!;
                //     });
                //   },
                //   items: testamentVersion.map<DropdownMenuItem<DropdownOption>>(
                //       (DropdownOption option) {
                //     return DropdownMenuItem<DropdownOption>(
                //       value: option,
                //       child: Text(
                //         option.display,
                //         style: TextStyle(fontSize: 12),
                //       ),
                //     );
                //   }).toList(),
                // ),
                // DropdownButton<String>(
                //   value: selectedDay2,
                //   onChanged: (newValue) {
                //     setState(() {
                //       selectedDay2 = newValue!;
                //     });
                //   },
                //   items: daysOfWeek.map<DropdownMenuItem<String>>((String day) {
                //     return DropdownMenuItem<String>(
                //       value: day,
                //       child: Text(
                //         day,
                //         style: TextStyle(fontSize: 12),
                //       ),
                //     );
                //   }).toList(),
                // ),
                // DropdownButton<String>(
                //   value: selectedDay3,
                //   onChanged: (newValue) {
                //     setState(() {
                //       selectedDay3 = newValue!;
                //     });
                //   },
                //   items: daysOfWeek.map<DropdownMenuItem<String>>((String day) {
                //     return DropdownMenuItem<String>(
                //       value: day,
                //       child: Text(
                //         day,
                //         style: TextStyle(fontSize: 12),
                //       ),
                //     );
                //   }).toList(),
                // ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                loadUrlAndExtractText();
              },
              child: Text('Load and Extract Text'),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 0.01,
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      'https://simplified.lsmchinese.org/lifestudy/ot/gen003.html'),
                ),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
              ),
            ),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Text(
                    extractedText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadUrlAndExtractText() async {
    if (webViewController != null) {
      await webViewController!.loadUrl(
        urlRequest: URLRequest(
          url: Uri.parse(
              'https://simplified.lsmchinese.org/lifestudy/ot/gen003.html'),
        ),
      );

      String jsCode = """
        var lsTextElement = document.querySelector('.ls-text');
        var extractedText = lsTextElement ? lsTextElement.textContent : '';
        extractedText;
      """;

      String? result =
          await webViewController!.evaluateJavascript(source: jsCode);
      setState(() {
        extractedText = result ?? '';
      });
    }
  }
}

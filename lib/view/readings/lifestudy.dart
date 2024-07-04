import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DropdownOption {
  final String value;
  final String display;

  DropdownOption(this.value, this.display);
}

class BookOption {
  final String value;
  final String display;
  final int chapter;
  final int? padNumber;

  BookOption(this.value, this.display, this.chapter, {this.padNumber});
}

class LifeStudyPage extends StatefulWidget {
  const LifeStudyPage({Key? key}) : super(key: key);

  @override
  _LifeStudyPageState createState() => _LifeStudyPageState();
}

class _LifeStudyPageState extends State<LifeStudyPage> {
  InAppWebViewController? webViewController;
  String extractedText = '';
  DropdownOption? selectedVersion = null;
  BookOption? selectedBook = null;
  var selectedChapter = null;
  var selectedBookOptions = null;
  List<DropdownMenuItem<String>>? selectedChapterOptions = null;

  List<DropdownOption> testamentVersion = [
    DropdownOption("ot", "旧约"),
    DropdownOption("nt", "新约"),
  ];

  List<BookOption> oldTestamentBooks = [
    BookOption("gen", "创世记", 120),
    BookOption("exo", "出埃及记", 185),
    BookOption("lev", "利未记", 64),
    BookOption("num", "民数记", 53),
    BookOption("DETU", "申命记", 30),
    BookOption("jos", "约书亚记", 15, padNumber: 2),
    BookOption("jud", "士师记", 10, padNumber: 2),
    BookOption("ruth", "路得记", 8, padNumber: 2),
    BookOption("sam", "撒母耳记", 38, padNumber: 2),
    BookOption("king", "列王纪", 23, padNumber: 2),
    BookOption("chr", "历代志", 13, padNumber: 2),
    BookOption("ezr", "以斯拉记", 5, padNumber: 2),
    BookOption("neh", "尼希米记", 5, padNumber: 2),
    BookOption("est", "以斯帖记", 2, padNumber: 2),
    BookOption("job", "约伯记", 38, padNumber: 2),
    BookOption("psa", "诗篇", 45, padNumber: 2),
    BookOption("pro", "箴言", 8, padNumber: 2),
    BookOption("ecc", "传道书", 2, padNumber: 2),
    BookOption("song", "雅歌", 10, padNumber: 2),
    BookOption("isa", "以赛亚书", 54, padNumber: 2),
    BookOption("jer", "耶利米书", 40, padNumber: 2),
    BookOption("lam", "耶利米哀歌", 4, padNumber: 2),
    BookOption("eze", "以西结书", 27, padNumber: 2),
    BookOption("dan", "但以理书", 17, padNumber: 2),
    BookOption("hos", "何西阿书", 9, padNumber: 2),
    BookOption("joe", "约珥书", 7, padNumber: 2),
    BookOption("amos", "阿摩司书", 3, padNumber: 2),
    BookOption("oba", "俄巴底亚书", 1, padNumber: 2),
    BookOption("jona", "约拿书", 1, padNumber: 2),
    BookOption("mich", "弥迦书", 4, padNumber: 2),
    BookOption("nahu", "那鸿书", 1, padNumber: 2),
    BookOption("haba", "哈巴谷书", 3, padNumber: 2),
    BookOption("zeph", "西番雅书", 1, padNumber: 2),
    BookOption("hag", "哈该书", 1, padNumber: 2),
    BookOption("zech", "撒迦利亚书", 15, padNumber: 2),
    BookOption("mala", "玛拉基书", 4, padNumber: 2),
  ];

  List<BookOption> newTestamentBooks = [
    BookOption("matt", "马太福音", 72, padNumber: 2),
    BookOption("mark", "马可福音", 70, padNumber: 2),
    BookOption("luke", "路加福音", 79, padNumber: 2),
    BookOption("john", "约翰福音", 51, padNumber: 2),
    BookOption("acts", "使徒行传", 72, padNumber: 2),
    BookOption("roma", "罗马书", 69, padNumber: 2),
    BookOption("1cor", "哥林多前书", 69, padNumber: 2),
    BookOption("2cor", "哥林多後书", 59, padNumber: 2),
    BookOption("Gala", "加拉太书", 46, padNumber: 2),
    BookOption("ephi", "以弗所书", 97, padNumber: 2),
    BookOption("phil", "腓立比书", 62, padNumber: 2),
    BookOption("col", "	歌罗西书", 65, padNumber: 2),
    BookOption("1the", "帖撒罗尼迦前书", 25, padNumber: 2),
    BookOption("2the", "帖撒罗尼迦後书", 7, padNumber: 2),
    BookOption("1tim", "提摩太前书", 12, padNumber: 2),
    BookOption("2tim", "提摩太後书", 8, padNumber: 2),
    BookOption("titu", "提多书", 6, padNumber: 2),
    BookOption("phmn", "腓利门书", 2, padNumber: 2),
    BookOption("hebr", "希伯来书", 69, padNumber: 2),
    BookOption("jame", "雅各书", 14, padNumber: 2),
    BookOption("1Pet", "彼得前书", 34, padNumber: 2),
    BookOption("2Pet", "彼得后书", 13, padNumber: 2),
    BookOption("1joh", "约翰一书", 40, padNumber: 2),
    BookOption("2joh", "约翰二书", 2, padNumber: 2),
    BookOption("3joh", "约翰参书", 2, padNumber: 2),
    BookOption("juda", "犹大书", 6, padNumber: 2),
    BookOption("Reve", "启示录", 68, padNumber: 2),
  ];

  @override
  void initState() {
    super.initState();
    selectedVersion = testamentVersion[0];
    selectedBookOptions = oldTestamentBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Life Study'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<DropdownOption>(
                  value: selectedVersion,
                  onChanged: (newValue) {
                    setState(() {
                      selectedVersion = newValue!;
                      if (newValue.value == "ot") {
                        selectedBookOptions = oldTestamentBooks;
                      } else {
                        selectedBookOptions = newTestamentBooks;
                      }
                    });
                  },
                  items: testamentVersion.map<DropdownMenuItem<DropdownOption>>(
                      (DropdownOption option) {
                    return DropdownMenuItem<DropdownOption>(
                      value: option,
                      child: Text(
                        option.display,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
                DropdownButton<BookOption>(
                  value: selectedBook,
                  onChanged: (newValue) {
                    setState(() {
                      selectedBook = newValue!;
                      selectedChapterOptions = setChaptersDropdown(
                          selectedBook?.chapter ?? 0, selectedBook?.padNumber);
                      if (selectedChapterOptions != null &&
                          selectedChapterOptions!.isNotEmpty) {
                        selectedChapter = selectedChapterOptions![0].value;
                        // Load text immediately when the book is changed
                        loadUrlAndExtractText();
                      }
                    });
                  },
                  items: selectedBookOptions
                      .map<DropdownMenuItem<BookOption>>((BookOption option) {
                    return DropdownMenuItem<BookOption>(
                      value: option,
                      child: Text(
                        option.display,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: selectedChapter,
                  onChanged: (newValue) {
                    setState(() {
                      selectedChapter = newValue!;
                      loadUrlAndExtractText();
                    });
                  },
                  items: selectedChapterOptions ?? [],
                ),
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
                  url: Uri.parse('https://line.twgbr.org/life-study/40.html'),
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
                    style: const TextStyle(fontSize: 16),
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
    var bookChapterString = selectedBook!.value + selectedChapter.toString();
    if (webViewController != null) {
      await webViewController!.loadUrl(
        urlRequest: URLRequest(
          url: Uri.parse(
              'https://simplified.lsmchinese.org/lifestudy/${selectedVersion?.value}/$bookChapterString.html'),
        ),
      );

      print(bookChapterString);

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

  List<DropdownMenuItem<String>> setChaptersDropdown(int maxChapters,
      [int? padNumbers]) {
    List<DropdownMenuItem<String>> chapters = [];
    for (int i = 1; i <= maxChapters; i++) {
      var padding = padNumbers ?? 3;
      String formattedValue = i.toString().padLeft(padding, '0');
      chapters.add(DropdownMenuItem<String>(
        value: formattedValue,
        child: Text(
          i.toString(),
          style: const TextStyle(fontSize: 12),
        ),
      ));
    }
    return chapters;
  }
}

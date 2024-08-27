import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const String FIT3077_API_KEY = 'jhGDFKbWBCNgQjJmdQGkbKzmMg6qHH';
const String JSON_TYPE = 'application/json';
const String ANY_TYPE = '*/*';

final kElevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.deepPurple[900],
  shape: const RoundedRectangleBorder(
    side: BorderSide(color: Colors.teal, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
);

class Colours {
  static Color primaryColour = const Color(0xFFF7F6F6);
  static Color secondaryColour = const Color(0xFF2196f3);
  static Color tertiaryColour = const Color(0xFFff8a89);
  static Color? quaternaryColour = Colors.orangeAccent[200];
  static Color grey = const Color(0xFF707070);
  static Color black = const Color(0xFF333333);
  static Color white = Colors.white;
  static Color? midGrey = Colors.grey[400];
  static Color? lighterGrey = Colors.grey[300];
  static Color? lightGrey = Colors.grey[200];
  static Color green = const Color(0xFF0AC350);
  static Color red = Colors.redAccent;
  static Color blue = const Color(0xFF4dd7fa);
  static Color purple = Colors.deepPurpleAccent;
}

class Dimensions {
  static double buttonRadius = 30.0;
  static double buttonHeight = 50.0;
  static double dialogHeight = 400.0;
  static double d_0 = 0.0;
  static double d_1 = 1.0;
  static double d_2 = 2.0;
  static double d_3 = 3.0;
  static double d_5 = 5.0;
  static double d_8 = 8.0;
  static double d_10 = 10.0;
  static double d_15 = 15.0;
  static double d_20 = 20.0;
  static double d_25 = 25.0;
  static double d_30 = 30.0;
  static double d_35 = 35.0;
  static double d_45 = 45.0;
  static double d_50 = 50.0;
  static double d_55 = 55.0;
  static double d_65 = 65.0;
  static double d_85 = 85.0;
  static double d_95 = 95.0;
  static double d_100 = 100.0;
  static double d_120 = 120.0;
  static double d_130 = 130.0;
  static double d_140 = 140.0;
  static double d_160 = 160.0;
  static double d_200 = 200.0;
  static double d_250 = 250.0;
  static double d_280 = 280.0;
  static double d_380 = 380.0;
}

class FontSizes {
  static double mainTitle = 25.0;
  static double title = 20.0;
  static double buttonText = 17.0;
  static double biggerText = 18.0;
  static double normalText = 15.0;
  static double smallText = 12.00;
  static double tinyText = 10.0;
}

class BordersRadius {
  static BorderRadius rightChatBubble = const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
      bottomLeft: Radius.circular(10));
  static BorderRadius leftChatBubble = const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(10));
  static BorderRadius chatImage = const BorderRadius.all(Radius.circular(8.0));
  static BorderRadius userRole = const BorderRadius.all(Radius.circular(5.0));
  static BorderRadius chatAvatar =
      const BorderRadius.all(Radius.circular(18.0));
  static BorderRadius profileAvatar =
      const BorderRadius.all(Radius.circular(45.0));
}

enum InformationCategory {
  morningRevival,
  churchNews,
  prayerItems,
  statisticReport,
  conferenceAndTrainingMaterials
}

Map<InformationCategory, String> informationCategory = {
  InformationCategory.morningRevival: "morningRevival",
  InformationCategory.churchNews: "churchNews",
  InformationCategory.prayerItems: "prayerItems",
  InformationCategory.statisticReport: "statisticReport",
  InformationCategory.conferenceAndTrainingMaterials:
      "conferenceAndTrainingMaterials"
};

const TextStyle kBodyText =
    TextStyle(fontSize: 15, color: Colors.white, height: 1.3);
const Color kWhite = Colors.white;
const Color kBlue = Color(0xff5663ff);

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [const Color(0xFF6448FE), const Color(0xFF5FC6FF)];
  static List<Color> sunset = [
    const Color(0xFFFE6197),
    const Color(0xFFFFB463)
  ];
  static List<Color> sea = [const Color(0xFF61A3FE), const Color(0xFF63FFD5)];
  static List<Color> mango = [const Color(0xFFFFA738), const Color(0xFFFFE130)];
  static List<Color> fire = [const Color(0xFFFF5DCD), const Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}

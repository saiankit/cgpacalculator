import 'package:flutter/material.dart';

import 'screen_config.dart';

class CustomIcons {
  static Icon arrowBackIOS = Icon(
    Icons.chevron_left,
    color: Colors.black,
    size: 40.0,
  );
}

class Converts {
  static double c8 = 1 * SizeConfig.textMultiplier;
  static double c12 = 1.5 * SizeConfig.textMultiplier;
  static double c16 = 2 * SizeConfig.textMultiplier;
  static double c20 = 2.5 * SizeConfig.textMultiplier;
  static double c24 = 3 * SizeConfig.textMultiplier;
  static double c32 = 4 * SizeConfig.textMultiplier;
  static double c40 = 5 * SizeConfig.textMultiplier;
  static double c48 = 6 * SizeConfig.textMultiplier;
  static double c56 = 7 * SizeConfig.textMultiplier;
  static double c64 = 8 * SizeConfig.textMultiplier;
  static double c72 = 9 * SizeConfig.textMultiplier;
  static double c80 = 10 * SizeConfig.textMultiplier;
  static double c88 = 11 * SizeConfig.textMultiplier;
  static double c96 = 12 * SizeConfig.textMultiplier;
  static double c104 = 13 * SizeConfig.textMultiplier;
  static double c112 = 14 * SizeConfig.textMultiplier;
  static double c120 = 15 * SizeConfig.textMultiplier;
  static double c128 = 16 * SizeConfig.textMultiplier;
  static double c136 = 17 * SizeConfig.textMultiplier;
  static double c144 = 18 * SizeConfig.textMultiplier;
  static double c152 = 19 * SizeConfig.textMultiplier;
  static double c160 = 20 * SizeConfig.textMultiplier;
  static double c168 = 21 * SizeConfig.textMultiplier;
  static double c176 = 22 * SizeConfig.textMultiplier;
  static double c184 = 23 * SizeConfig.textMultiplier;
  static double c192 = 24 * SizeConfig.textMultiplier;
  static double c200 = 25 * SizeConfig.textMultiplier;
  static double c208 = 26 * SizeConfig.textMultiplier;
  static double c216 = 27 * SizeConfig.textMultiplier;
  static double c224 = 28 * SizeConfig.textMultiplier;
  static double c232 = 29 * SizeConfig.textMultiplier;
  static double c240 = 30 * SizeConfig.textMultiplier;
  static double c248 = 31 * SizeConfig.textMultiplier;
  static double c256 = 32 * SizeConfig.textMultiplier;
  static double c264 = 33 * SizeConfig.textMultiplier;
  static double c272 = 34 * SizeConfig.textMultiplier;
  static double c280 = 35 * SizeConfig.textMultiplier;
  static double c288 = 36 * SizeConfig.textMultiplier;
  static double c296 = 37 * SizeConfig.textMultiplier;
  static double c304 = 38 * SizeConfig.textMultiplier;
  static double c312 = 39 * SizeConfig.textMultiplier;
  static double c320 = 40 * SizeConfig.textMultiplier;
  static double c350 = 50 * SizeConfig.textMultiplier;
}

class ThemeStyles {
  static TextStyle t8TextStyle = TextStyle(
    fontSize: Converts.c8,
    fontWeight: FontWeight.w700,
  );
  static TextStyle t12TextStyle = TextStyle(
    fontSize: Converts.c12,
    fontWeight: FontWeight.w700,
  );
  static TextStyle t16TextStyle = TextStyle(
    fontSize: Converts.c16,
    fontWeight: FontWeight.w700,
  );
  static TextStyle t20TextStyle = TextStyle(
    fontSize: Converts.c20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static TextStyle t24TextStyle = TextStyle(
    fontSize: Converts.c24,
    fontWeight: FontWeight.w700,
  );
  static TextStyle t32TextStyle = TextStyle(
    fontSize: Converts.c32,
    fontWeight: FontWeight.w700,
  );
  static TextStyle t40TextStyle = TextStyle(
    fontSize: Converts.c40,
    fontWeight: FontWeight.w700,
  );

  static BoxDecoration courseCardDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Converts.c8),
      bottomLeft: Radius.circular(Converts.c8),
      topRight: Radius.circular(Converts.c32),
      bottomRight: Radius.circular(Converts.c32),
    ),
  );

  static BoxDecoration courseCardCourseInfo = BoxDecoration(
    borderRadius: BorderRadius.circular(Converts.c8),
    color: Color(0xff212121),
  );

  static BoxDecoration courseCardGradeInfo = BoxDecoration(
    borderRadius: BorderRadius.circular(Converts.c32),
    color: Color(0xff212121),
  );

  static BoxDecoration addNewCourse = BoxDecoration(
    border: Border.all(
      color: Color(0xFFC4C4C4).withOpacity(0.5),
    ),
    borderRadius: BorderRadius.circular(Converts.c8),
    color: Color(0xFFC4C4C4).withOpacity(0.2),
  );

  static BoxDecoration modalBottomSheetDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Converts.c32),
      topRight: Radius.circular(Converts.c32),
    ),
  );
}

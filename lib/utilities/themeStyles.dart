import 'package:flutter/material.dart';

class ThemeStyles {
  static TextStyle titleTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 15.0,
    color: Colors.grey[600],
  );

  static TextStyle gpaTextStyle =
      TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700);

  static TextStyle gpaNumberTextStyle = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.w700,
  );

  static BoxDecoration courseCardDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10.0),
      bottomLeft: Radius.circular(10.0),
      topRight: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    ),
    color: Colors.white,
  );

  static BoxDecoration courseCardCourseInfo = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.black,
  );

  static BoxDecoration courseCardGradeInfo = BoxDecoration(
    borderRadius: BorderRadius.circular(30.0),
    color: Colors.black,
  );

  static BoxDecoration addNewCourse = BoxDecoration(
    border: Border.all(
      color: Color(0xFFC4C4C4).withOpacity(0.5),
    ),
    borderRadius: BorderRadius.circular(8.0),
    color: Color(0xFFC4C4C4).withOpacity(0.2),
  );

  static BoxDecoration modalBottomSheetDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: const Radius.circular(30.0),
      topRight: const Radius.circular(30.0),
    ),
  );
}

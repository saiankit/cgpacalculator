import 'package:flutter/material.dart';

class CourseInfoState extends ChangeNotifier {
  String defaultSemesterManual = '1 - 1';
  int selectedCredits = 4;
  String courseCode;
  String courseID;
  int courseGrade = 10;

  void changeManualSemester(String newSemester) {
    defaultSemesterManual = newSemester;
    notifyListeners();
  }

  void changeCredits(int newCredits) {
    selectedCredits = newCredits;
    notifyListeners();
  }

  void changeCourseCode(String newCourseCode) {
    courseCode = newCourseCode;
    notifyListeners();
  }

  void changeCourseID(String newCourseID) {
    courseID = newCourseID;
    notifyListeners();
  }

  void changeGrade(int newGrade) {
    courseGrade = newGrade;
    notifyListeners();
  }
}

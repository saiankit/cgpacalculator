import 'package:flutter/material.dart';

class CourseInfoState extends ChangeNotifier {
  int selectedCredits = 4;
  String courseCode;
  String courseID;
  int courseGrade = 10;

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

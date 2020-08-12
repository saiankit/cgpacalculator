import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:flutter/material.dart';

class CourseInfoState extends ChangeNotifier {
  String defaultSemesterManual = '1 - 1';
  int selectedCredits = 4;
  String courseCode;
  String courseID;
  int courseGrade = 10;
  String manualEntryCG = '0';
  String manualExhaust = '0';
  var selectedSemester = semesterList[0];
  String cummulativeGradePointAverage = "0.00";
  String semesterGradePointAverage = "0.00";

  void changeToSemester(String newSemester) {
    selectedSemester = newSemester;
    notifyListeners();
  }

  void changeManualCredits(String newManualCredits) {
    manualExhaust = newManualCredits;
    notifyListeners();
  }

  void changeManualCG(String newManualAdd) {
    manualEntryCG = newManualAdd;
    notifyListeners();
  }

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

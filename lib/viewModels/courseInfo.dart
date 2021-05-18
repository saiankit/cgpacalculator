import 'package:CgpaCalculator/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseInfoState extends ChangeNotifier {
  String defaultSemesterManual = '1 - 1';
  int selectedCredits = 4;
  String courseCode;
  String courseID;
  int courseGrade = 10;
  String manualEntryCG = '0';
  String manualExhaust = '0';
  String selectedSemester = semesterSharedPreferences;
  String cummulativeGradePointAverage = "0.00";
  String semesterGradePointAverage = "0.00";
  String primaryDiscipline = 'A1';
  String secondaryDiscipline = 'B1';
  String minor = 'Finance';

  bool minorExists = false;
  bool secondaryDisciplineExists = false;

  void changeToSemester(String newSemester) async {
    selectedSemester = newSemester;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sem', newSemester);
    notifyListeners();
  }

  void changePrimaryDiscipline(String newDiscipline) async {
    primaryDiscipline = newDiscipline;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('primaryDiscipline', primaryDiscipline);
    notifyListeners();
  }

  void changeSecondaryDiscipline(String newDiscipline) async {
    secondaryDiscipline = newDiscipline;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('secondaryDiscipline', secondaryDiscipline);
    notifyListeners();
  }

  void changeMinor(String newMinor) async {
    minor = newMinor;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('minor', minor);
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

  void toggleMinor() {
    minorExists = !minorExists;
    notifyListeners();
  }

  void toggleSecondaryDiscipline() {
    secondaryDisciplineExists = !secondaryDisciplineExists;
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

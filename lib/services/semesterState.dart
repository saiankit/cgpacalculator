import 'package:CgpaCalculator/models/courseDetails.dart';
import 'package:flutter/material.dart';

List<String> sGList = ['8.33', '8.1'];

class SemesterState extends ChangeNotifier {
  var selectedSemester = semesterList[0];
  var semesterGradePointAverage = sGList[1];

  void changeToSemester(String newSemester) {
    selectedSemester = newSemester;
    notifyListeners();
  }
}

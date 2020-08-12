import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:flutter/material.dart';

class SemesterState extends ChangeNotifier {
  var selectedSemester = semesterList[0];
  String cummulativeGradePointAverage = "0.00";
  String semesterGradePointAverage = "0.00";

  void changeToSemester(String newSemester) {
    selectedSemester = newSemester;
    notifyListeners();
  }
}

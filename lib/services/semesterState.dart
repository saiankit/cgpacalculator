import 'package:CgpaCalculator/models/courseDetails.dart';
import 'package:flutter/material.dart';

class SemesterState extends ChangeNotifier {
  var selectedSemester = semesterList[0];

  void changeToSemester(String newSemester) {
    selectedSemester = newSemester;
    notifyListeners();
  }
}

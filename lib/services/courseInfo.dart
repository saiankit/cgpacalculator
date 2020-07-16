import 'package:flutter/material.dart';

class CourseInfoState extends ChangeNotifier {
  int selectedCredits = 1;

  int selectedGradeAchieved = 10;

  void changeCredits(int newCredits) {
    selectedCredits = newCredits;
    notifyListeners();
  }

  void changeGrade(int newGrade) {
    selectedGradeAchieved = newGrade;
    notifyListeners();
  }
}

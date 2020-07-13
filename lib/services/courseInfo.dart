import 'package:flutter/material.dart';

class CourseInfoState extends ChangeNotifier {
  int selectedCredits = 1;

  void changeCredits(int newCredits) {
    selectedCredits = newCredits;
    notifyListeners();
  }
}

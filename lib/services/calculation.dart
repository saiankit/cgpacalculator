import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String calculateGPA(AsyncSnapshot<List<Course>> snapshot) {
  int theProduct = 0;
  int creditsExhaustedInSemester = 0;
  String semesterGradePointAverage;
  for (var i = 0; i < snapshot.data.length; i++) {
    theProduct +=
        snapshot.data[i].gradeAchieved * snapshot.data[i].courseCredits;
    creditsExhaustedInSemester += snapshot.data[i].courseCredits;
  }
  double sg = double.parse(
      (theProduct / creditsExhaustedInSemester).toStringAsFixed(2));

  if (sg.isNaN) {
    semesterGradePointAverage = '0.00';
  } else {
    semesterGradePointAverage = sg.toString();
  }

  return semesterGradePointAverage;
}

Future<String> calculateCGPA(AsyncSnapshot<List<Course>> snapshot) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String manualCG = prefs.getString('manualCG');

  String manual = prefs.getString('manualCredits');
  int manualInt = int.parse(manual);
  int creditsExhaustedInSemester = manualInt != null ? manualInt : 0;
  String semesterGradePointAverage;
  double theProduct = manualCG != null ? double.parse(manualCG) * manualInt : 0;
  for (var i = 0; i < snapshot.data.length; i++) {
    theProduct +=
        snapshot.data[i].gradeAchieved * snapshot.data[i].courseCredits;
    creditsExhaustedInSemester += snapshot.data[i].courseCredits;
  }
  print('theProduct' + theProduct.toString());
  print('credExhau' + creditsExhaustedInSemester.toString());
  double sg = double.parse(
      (theProduct / creditsExhaustedInSemester).toStringAsFixed(2));

  if (sg.isNaN) {
    semesterGradePointAverage = '0.00';
  } else {
    semesterGradePointAverage = sg.toString();
  }

  return semesterGradePointAverage;
}

Future<String> countCredits(
  AsyncSnapshot<List<Course>> snapshot,
) async {
  int cred = 0;
  String credits;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String manual = prefs.getString('manualCredits');
  int manualInt = int.parse(manual);
  for (var i = 0; i < snapshot.data.length; i++) {
    cred += snapshot.data[i].courseCredits;
  }
  if (cred.isNaN) {
    credits = '0.00';
  } else {
    credits = (manualInt + cred).toString();
  }

  return credits;
}

String countSemCredits(
  AsyncSnapshot<List<Course>> snapshot,
) {
  int cred = 0;
  String credits;

  for (var i = 0; i < snapshot.data.length; i++) {
    cred += snapshot.data[i].courseCredits;
  }
  if (cred.isNaN) {
    credits = '0.00';
  } else {
    credits = cred.toString();
  }

  return credits;
}

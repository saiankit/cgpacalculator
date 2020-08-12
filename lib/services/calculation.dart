import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/providerStates/courseInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

String countCredits(
    {AsyncSnapshot<List<Course>> snapshot,
    bool isCGPA,
    BuildContext homeScreenContext}) {
  int cred = 0;
  String credits;

  for (var i = 0; i < snapshot.data.length; i++) {
    cred += snapshot.data[i].courseCredits;
  }
  String manual = Provider.of<CourseInfoState>(homeScreenContext, listen: false)
      .manualExhaust;
  int credManual = int.parse(manual);
  if (cred.isNaN) {
    credits = '0.00';
  } else {
    if (isCGPA) {
      credits = (cred + credManual).toString();
    } else {
      credits = cred.toString();
    }
  }

  return credits;
}

import 'package:flutter/material.dart';

import 'moor_database_service.dart';

// [1] : Semester Grade Point Calculator
// This function is used to calculate the semester grade point using the required stream
String calculateGPA(AsyncSnapshot<List<Course>> snapshot) {
  //SGPA [String] that is returned by the function
  String semesterGradePointAverage;

  //Loop Variable
  int productCount = 0;
  // The loopVariable used to multiply the credits and grade achived in particular semester courses list of the user
  int creditsCount = 0;
  // The loopVariable used to count the credits in particular semester courses list of the user

  //Loop to count the SGPA from the snapshot of the watchAllCoursesBySemesterCode Stream

  for (var i = 0; i < snapshot.data!.length; i++) {
    if (snapshot.data![i].gradeAchieved != 0) {
      productCount +=
          snapshot.data![i].gradeAchieved * snapshot.data![i].courseCredits;
      creditsCount += snapshot.data![i].courseCredits;
    }
  }
  double doubleSGPA =
      double.parse((productCount / creditsCount).toStringAsFixed(2));
  // floating point value of the final result obtained after the loop by dividing the productCount and creditsCount

  //Asserting the doubleSGPA and converting it to String as neccessary
  if (doubleSGPA.isNaN) {
    semesterGradePointAverage = '0.00';
  } else {
    semesterGradePointAverage = doubleSGPA.toString();
  }

  return semesterGradePointAverage;
}

// [2] : Cummulative Grade Point Calculator
// Since it contains a future response a future builder should be used at the access location
String calculateCGPA(AsyncSnapshot<List<Course>> snapshot, String manualCGPA,
    String manualCredits) {
  String
      cummulativeGradePointAverage; //CGPA [String] that is returned by the function

  //Initial Values
  double initialCGPA =
      manualCGPA == 'None' ? double.parse('0.00') : double.parse(manualCGPA);
  //Accessing the initial CGPA added by the user manually stored in Shared Preferences
  int initialCredits = manualCredits == 'None' ? 0 : int.parse(manualCredits);
  //Accessing the initial credits added by the user manually stored in Shared Preferences
  double initialProduct =
      initialCredits != null ? initialCGPA * initialCredits : 0.00;
  //Computing the initial product added by the user manually stored in Shared Preferences

  //Loop variables
  int creditsCount = initialCredits;
  // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
  double productCount = initialProduct;
  // The loopVariable used to multiply the credits and grade achived in completed courses list of the user initialised by the initial product

  //Loop to count the CGPA from the snapshot of the watchAllCourses Stream
  for (var i = 0; i < snapshot.data!.length; i++) {
    if (snapshot.data![i].gradeAchieved != 0) {
      productCount +=
          snapshot.data![i].gradeAchieved * snapshot.data![i].courseCredits;
      creditsCount += snapshot.data![i].courseCredits;
    }
  }

  double doubleCGPA = double.parse((productCount / creditsCount).toStringAsFixed(
      2)); // floating point value of the final result obtained after the loop by dividing the productCount and creditsCount
  //Asserting the doubleCGPA and converting it to String as neccessary
  if (doubleCGPA.isNaN) {
    cummulativeGradePointAverage = '0.00';
  } else {
    cummulativeGradePointAverage = doubleCGPA.toString();
  }

  return cummulativeGradePointAverage;
}

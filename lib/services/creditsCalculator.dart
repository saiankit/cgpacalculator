import 'package:CgpaCalculator/data/hive_api.dart';
import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:flutter/material.dart';

// [1] : Particular Semester Credits Count
// This function is used to count credtis exhausted in a particular semester using the required stream
String countSemCredits(AsyncSnapshot<List<Course>> snapshot) {
  String
      semesterCredits; //Credits in a semester [String] that is returned by the function
  int creditsCount =
      0; // The loopVariable used to count the credits in particular semester courses list of the user
  //Loop to count the total credits from the snapshot of the watchAllCoursesBySemesterCode Stream
  for (var i = 0; i < snapshot.data.length; i++) {
    creditsCount += snapshot.data[i].courseCredits;
  }
  //Asserting the Credits count
  if (creditsCount.isNaN) {
    semesterCredits = '0';
  } else {
    semesterCredits = creditsCount.toString();
  }

  return semesterCredits;
}

// [2] : Total Credits Count
// This function is used to count total credits exhausted
// It also takes care of the initial credits if any manual entry until particular semester is added by the user
// Since it contains a future response a future builder should be used at the access location
String countCredits(AsyncSnapshot<List<Course>> snapshot) {
  String totalCredits; //Total Credits [String] that is returned by the function

  int initialCredits = hiveGetData('manualCredits') == null
      ? 0
      : int.parse(hiveGetData(
          'manualCredits')); //Accessing the initial credits added by the user manually stored in Shared Preferences
  int creditsCount =
      initialCredits; // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
  //Loop to count the total credits from the snapshot of the watchAllCourses Stream
  for (var i = 0; i < snapshot.data.length; i++) {
    creditsCount += snapshot.data[i].courseCredits;
  }

  //Asserting the total Credits
  if (creditsCount.isNaN) {
    totalCredits = '0';
  } else {
    totalCredits = creditsCount.toString();
  }

  return totalCredits;
}

import 'package:flutter/material.dart';

import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/localData/departments/departmentExports.dart';

String countOELCredits(AsyncSnapshot<List<Course>> snapshot, String branch) {
  String totalCredits; //Total Credits [String] that is returned by the function
  int creditsCount =
      0; // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
  //Loop to count the total credits from the snapshot of the watchAllCourses Stream
  List<Map<String, dynamic>> coreCoursesList;
  List<Map<String, dynamic>> disciplinaryCoursesList;
  if (branch == 'A1') {
    coreCoursesList = a1CoreCoursesList;
    disciplinaryCoursesList = a1DisciplinaryElectiveList;
  } else if (branch == 'A2') {
    coreCoursesList = a2CoreCoursesList;
    disciplinaryCoursesList = a2DisciplinaryElectiveList;
  } else if (branch == 'A3') {
    coreCoursesList = a3CoreCoursesList;
    disciplinaryCoursesList = a3DisciplinaryElectiveList;
  } else if (branch == 'A4') {
    coreCoursesList = a4CoreCoursesList;
    disciplinaryCoursesList = a4DisciplinaryElectiveList;
  } else if (branch == 'A5') {
    coreCoursesList = a5CoreCoursesList;
    disciplinaryCoursesList = a5DisciplinaryElectiveList;
  } else if (branch == 'AA') {
    coreCoursesList = aaCoreCoursesList;
    disciplinaryCoursesList = aaDisciplinaryElectiveList;
  } else if (branch == 'A7') {
    coreCoursesList = a7CoreCoursesList;
    disciplinaryCoursesList = a7DisciplinaryElectiveList;
  } else if (branch == 'A8') {
    coreCoursesList = a8CoreCoursesList;
    disciplinaryCoursesList = a8DisciplinaryElectiveList;
  } else if (branch == 'B1') {
    coreCoursesList = b1CoreCoursesList;
    disciplinaryCoursesList = b1DisciplinaryElectiveList;
  } else if (branch == 'B2') {
    coreCoursesList = b2CoreCoursesList;
    disciplinaryCoursesList = b2DisciplinaryElectiveList;
  } else if (branch == 'B3') {
    coreCoursesList = b3CoreCoursesList;
    disciplinaryCoursesList = b3DisciplinaryElectiveList;
  } else if (branch == 'B4') {
    coreCoursesList = b4CoreCoursesList;
    disciplinaryCoursesList = b4DisciplinaryElectiveList;
  } else if (branch == 'B5') {
    coreCoursesList = b5CoreCoursesList;
    disciplinaryCoursesList = b5DisciplinaryElectiveList;
  }

  for (var i = 0; i < snapshot.data.length; i++) {
    var data = snapshot.data[i];
    bool existsDEL = disciplinaryCoursesList.any((course) =>
        (course['courseCode'] == data.courseCode) &&
        (course['courseID'] == data.courseID));
    bool existsCore = coreCoursesList.any((course) =>
        (course['courseCode'] == data.courseCode) &&
        (course['courseID'] == data.courseID));
    bool existsComp = compulsoryCoursesList.any((course) =>
        (course['courseCode'] == data.courseCode) &&
        (course['courseID'] == data.courseID));
    bool existsHEL = (data.courseCode == "HSS") || (data.courseCode == "GS");
    List<String> open = [];
    if (!existsDEL && !existsCore && !existsComp && !existsHEL) {
      creditsCount += data.courseCredits;
      open.add(data.courseTitle);
    }
  }

  //Asserting the total OEL Credits
  if (creditsCount.isNaN) {
    totalCredits = '0';
  } else {
    totalCredits = creditsCount.toString();
  }

  return totalCredits;
}

String countDELCredits(AsyncSnapshot<List<Course>> snapshot, String branch) {
  String totalCredits; //Total Credits [String] that is returned by the function
  int creditsCount =
      0; // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
  //Loop to count the total credits from the snapshot of the watchAllCourses Stream
  List<Map<String, dynamic>> disciplinaryCoursesList;
  if (branch == 'a1') {
    disciplinaryCoursesList = a1DisciplinaryElectiveList;
  } else if (branch == 'a2') {
    disciplinaryCoursesList = a2DisciplinaryElectiveList;
  } else if (branch == 'a3') {
    disciplinaryCoursesList = a3DisciplinaryElectiveList;
  } else if (branch == 'a4') {
    disciplinaryCoursesList = a4DisciplinaryElectiveList;
  } else if (branch == 'a5') {
    disciplinaryCoursesList = a5DisciplinaryElectiveList;
  } else if (branch == 'aa') {
    disciplinaryCoursesList = aaDisciplinaryElectiveList;
  } else if (branch == 'a7') {
    disciplinaryCoursesList = a7DisciplinaryElectiveList;
  } else if (branch == 'a8') {
    disciplinaryCoursesList = a8DisciplinaryElectiveList;
  } else if (branch == 'b1') {
    disciplinaryCoursesList = b1DisciplinaryElectiveList;
  } else if (branch == 'b2') {
    disciplinaryCoursesList = b2DisciplinaryElectiveList;
  } else if (branch == 'b3') {
    disciplinaryCoursesList = b3DisciplinaryElectiveList;
  } else if (branch == 'b4') {
    disciplinaryCoursesList = b4DisciplinaryElectiveList;
  } else if (branch == 'b5') {
    disciplinaryCoursesList = b5DisciplinaryElectiveList;
  }

  for (var i = 0; i < snapshot.data.length; i++) {
    var data = snapshot.data[i];
    bool existsDEL = disciplinaryCoursesList.any((course) =>
        (course['courseCode'] == data.courseCode) &&
        (course['courseID'] == data.courseID));
    if (existsDEL) {
      creditsCount += data.courseCredits;
    }
  }

  //Asserting the total OEL Credits
  if (creditsCount.isNaN) {
    totalCredits = '0';
  } else {
    totalCredits = creditsCount.toString();
  }

  return totalCredits;
}

String countHelCredits(AsyncSnapshot<List<Course>> snapshot) {
  String totalCredits; //Total Credits [String] that is returned by the function
  int creditsCount =
      0; // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
  //Loop to count the total credits from the snapshot of the watchAllCourses Stream
  for (var i = 0; i < snapshot.data.length; i++) {
    if (snapshot.data[i].courseCode.startsWith('GS') ||
        snapshot.data[i].courseCode.startsWith('HSS'))
      creditsCount += snapshot.data[i].courseCredits;
  }

  //Asserting the total HEL Credits
  if (creditsCount.isNaN) {
    totalCredits = '0';
  } else {
    totalCredits = creditsCount.toString();
  }

  return totalCredits;
}

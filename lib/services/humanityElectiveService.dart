import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/localData/humanitiesCourseData.dart';
import 'package:CgpaCalculator/services/openElectiveService.dart';
import 'package:flutter/material.dart';

class HumanityElectiveService {
  String countCredits(AsyncSnapshot<List<Course>> snapshot) {
    String
        totalCredits; //Total Credits [String] that is returned by the function
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

  String countCourses(AsyncSnapshot<List<Course>> snapshot) {
    String
        totalCourses; //Total Credits [String] that is returned by the function
    int creditsCourses =
        0; // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
    //Loop to count the total credits from the snapshot of the watchAllCourses Stream
    for (var i = 0; i < snapshot.data.length; i++) {
      if (snapshot.data[i].courseCode.startsWith('GS') ||
          snapshot.data[i].courseCode.startsWith('HSS')) creditsCourses++;
    }

    //Asserting the total HEL Credits
    if (creditsCourses.isNaN) {
      totalCourses = '0';
    } else {
      totalCourses = creditsCourses.toString();
    }

    return totalCourses;
  }

  List<DummyCourseModel> getCompletedHumanityElecitvesList(
      AsyncSnapshot<List<Course>> snapshot) {
    List<DummyCourseModel> res = [];
    for (var i = 0; i < snapshot.data.length; i++) {
      if (snapshot.data[i].courseCode.startsWith('GS') ||
          snapshot.data[i].courseCode.startsWith('HSS')) {
        DummyCourseModel newCourse = DummyCourseModel(
          courseCode: snapshot.data[i].courseCode,
          courseCredits: snapshot.data[i].courseCredits.toString(),
          courseID: snapshot.data[i].courseID,
          courseTitle: snapshot.data[i].courseTitle,
        );
        res.add(newCourse);
      }
    }

    return res;
  }

  List<DummyCourseModel> getMoreHumanityElecitvesList(
      AsyncSnapshot<List<Course>> snapshot) {
    List<Course> completedHumanities = [];

    for (var i = 0; i < snapshot.data.length; i++)
      if (snapshot.data[i].courseCode.startsWith('GS') ||
          snapshot.data[i].courseCode.startsWith('HSS'))
        completedHumanities.add(snapshot.data[i]);
    List<DummyCourseModel> left = [];
    for (var i = 0; i < humanityCoursesData.length; i++) {
      for (var j = 0; j < completedHumanities.length; j++) {
        if ((completedHumanities[j].courseCode +
                completedHumanities[j].courseID) !=
            (humanityCoursesData[i]['courseCode'] +
                humanityCoursesData[i]['courseID'])) {

            DummyCourseModel newCourse = DummyCourseModel(
              courseCode: humanityCoursesData[i]['courseCode'],
              courseCredits: humanityCoursesData[i]['courseCredits'],
              courseID: humanityCoursesData[i]['courseID'],
              courseTitle: humanityCoursesData[i]['courseTitle'],
            );
            left.add(newCourse);
        }
      }
    }

    return left;
  }
}

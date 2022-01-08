import 'package:flutter/material.dart';

import '../data/courses_data.dart';
import '../models/course_model_simplified.dart';
import 'moor_database_service.dart';

class HumanityElectiveService {
  String countCredits(AsyncSnapshot<List<Course>> snapshot) {
    String
        totalCredits; //Total Credits [String] that is returned by the function
    int creditsCount =
        0; // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
    //Loop to count the total credits from the snapshot of the watchAllCourses Stream
    for (var i = 0; i < snapshot.data!.length; i++) {
      if (snapshot.data![i].courseCode.startsWith('GS') ||
          snapshot.data![i].courseCode.startsWith('HSS'))
        creditsCount += snapshot.data![i].courseCredits;
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
    String totalCourses;
    //Total Credits [String] that is returned by the function
    int creditsCourses = 0;
    // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
    //Loop to count the total credits from the snapshot of the watchAllCourses Stream
    for (var i = 0; i < snapshot.data!.length; i++) {
      if (snapshot.data![i].courseCode.startsWith('GS') ||
          snapshot.data![i].courseCode.startsWith('HSS')) creditsCourses++;
    }

    //Asserting the total HEL Credits
    if (creditsCourses.isNaN) {
      totalCourses = '0';
    } else {
      totalCourses = creditsCourses.toString();
    }

    return totalCourses;
  }

  List<CourseSimplified> getCompletedHumanityElecitvesList(
      AsyncSnapshot<List<Course>> snapshot) {
    List<CourseSimplified> res = [];
    for (var i = 0; i < snapshot.data!.length; i++) {
      if (snapshot.data![i].courseCode.startsWith('GS') ||
          snapshot.data![i].courseCode.startsWith('HSS')) {
        CourseSimplified newCourse = CourseSimplified(
          courseCode: snapshot.data![i].courseCode,
          courseCredits: snapshot.data![i].courseCredits.toString(),
          courseID: snapshot.data![i].courseID,
          courseTitle: snapshot.data![i].courseTitle,
        );
        res.add(newCourse);
      }
    }

    return res;
  }

  List<CourseSimplified> getMoreHumanityElecitvesList(
      AsyncSnapshot<List<Course>> snapshot) {
    List<Course> completedHumanities = [];

    for (var i = 0; i < snapshot.data!.length; i++)
      if (snapshot.data![i].courseCode.startsWith('GS') ||
          snapshot.data![i].courseCode.startsWith('HSS'))
        completedHumanities.add(snapshot.data![i]);
    List<CourseSimplified> left = [];
    for (var i = 0; i < coursesData.length; i++) {
      if (coursesData[i]['courseCode'].startsWith('GS') ||
          coursesData[i]['courseCode'].startsWith('HSS')) {
        for (var j = 0; j < completedHumanities.length; j++) {
          if ((completedHumanities[j].courseCode +
                  completedHumanities[j].courseID) !=
              (coursesData[i]['courseCode'] + coursesData[i]['courseID'])) {
            CourseSimplified newCourse = CourseSimplified(
              courseCode: coursesData[i]['courseCode'],
              courseCredits: coursesData[i]['courseCredits'],
              courseID: coursesData[i]['courseID'],
              courseTitle: coursesData[i]['courseTitle'],
            );
            left.add(newCourse);
          }
        }
      }
    }

    return left;
  }
}

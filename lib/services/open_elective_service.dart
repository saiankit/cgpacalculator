import 'package:flutter/material.dart';

import '../data/course_meta_data.dart';
import '../data/courses_data.dart';
import '../models/course_model_simplified.dart';
import 'moor_database_service.dart';

class OpenElectiveService {
  bool isCourseOpenElective(String courseID, String courseCode, String branch) {
    bool isCoreElective = false;
    bool isDEL = false;
    for (var i = 0; i < coursesData.length; i++) {
      if (coursesData[i]['cdcList'] != null) {
        for (var j = 0; j < coursesData[i]['cdcList'].length; j++) {
          if (coursesData[i]['cdcList'][j] == branch) {
            isCoreElective = true;
          }
        }
      }
    }

    for (var i = 0; i < coursesData.length; i++) {
      if (coursesData[i]['delList'] != null) {
        for (var j = 0; j < coursesData[i]['delList'].length; j++) {
          if (coursesData[i]['delList'][j] == branch) {
            isDEL = true;
          }
        }
      }
    }

    bool existsComp = compulsoryCoursesList.any((course) =>
        (course['courseCode'] == courseCode) &&
        (course['courseID'] == courseID));
    bool existsHEL = (courseCode == "HSS") || (courseCode == "GS");
    if (!isDEL && !isCoreElective && !existsComp && !existsHEL) return true;
    return false;
  }

  String countCredits(AsyncSnapshot<List<Course>> snapshot, String branch) {
    String
        totalCredits; //Total Credits [String] that is returned by the function
    int creditsCount = 0;

    for (var i = 0; i < snapshot.data!.length; i++) {
      var data = snapshot.data![i];
      if (isCourseOpenElective(data.courseID, data.courseCode, branch)) {
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

  String countCourses(AsyncSnapshot<List<Course>> snapshot, String branch) {
    String
        coursesCountString; //Total Credits [String] that is returned by the function
    int coursesCount =
        0; // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
    //Loop to count the total credits from the snapshot of the watchAllCourses Stream
    for (var i = 0; i < snapshot.data!.length; i++) {
      var data = snapshot.data![i];
      if (isCourseOpenElective(data.courseID, data.courseCode, branch)) {
        coursesCount++;
      }
    }

    //Asserting the total OEL Credits
    if (coursesCount.isNaN) {
      coursesCountString = '0';
    } else {
      coursesCountString = coursesCount.toString();
    }

    return coursesCountString;
  }

  List<CourseSimplified> getCompletedOpenElecitvesList(
      AsyncSnapshot<List<Course>> snapshot, String branch) {
    List<CourseSimplified> completedOpenElectives = [];
    for (var i = 0; i < snapshot.data!.length; i++) {
      var data = snapshot.data![i];
      if (isCourseOpenElective(data.courseID, data.courseCode, branch)) {
        CourseSimplified newCourse = CourseSimplified(
          courseCode: snapshot.data![i].courseCode,
          courseCredits: snapshot.data![i].courseCredits.toString(),
          courseID: snapshot.data![i].courseID,
          courseTitle: snapshot.data![i].courseTitle,
        );
        completedOpenElectives.add(newCourse);
      }
    }

    return completedOpenElectives;
  }

  List<CourseSimplified> getMoreOpenElectivesList(
      AsyncSnapshot<List<Course>> snapshot, String branch) {
    List<CourseSimplified> left = [];
    List<CourseSimplified> completedOpenElectives =
        getCompletedOpenElecitvesList(snapshot, branch);

    for (var i = 0; i < coursesData.length; i++) {
      for (var j = 0; j < completedOpenElectives.length; j++) {
        if (isCourseOpenElective(
            coursesData[i]['courseID'], coursesData[i]['courseCode'], branch)) {
          if ((completedOpenElectives[j].courseCode +
                  completedOpenElectives[j].courseID) !=
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

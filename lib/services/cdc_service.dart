import 'package:flutter/material.dart';

import '../data/courses_data.dart';
import '../models/course_model_simplified.dart';
import 'moor_database_service.dart';

class CDCService {
  String countCredits(AsyncSnapshot<List<Course>> snapshot, String branch) {
    String totalCredits;
    //Total Credits [String] that is returned by the function
    int creditsCount = 0;
    // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits

    //Loop to count the total credits from the snapshot of the watchAllCourses Stream

    for (var i = 0; i < coursesData.length; i++) {
      for (var j = 0; j < coursesData[i]['cdcList'].length; j++) {
        if (coursesData[i]['cdcList'][j] == branch) {
          for (var k = 0; k < snapshot.data!.length; k++) {
            var data = snapshot.data![k];
            if (data.courseCode == coursesData[i]['courseCode'] &&
                data.courseID == coursesData[i]['courseID']) {
              creditsCount += data.courseCredits;
            }
          }
        }
      }
    }

    //Asserting the total DEL Credits
    if (creditsCount.isNaN) {
      totalCredits = '0';
    } else {
      totalCredits = creditsCount.toString();
    }

    return totalCredits;
  }

  String countCourses(AsyncSnapshot<List<Course>> snapshot, String branch) {
    String coursesCountString;
    //Total Credits [String] that is returned by the function
    int coursesCount = 0;
    // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
    //Loop to count the total credits from the snapshot of the watchAllCourses Stream

    for (var i = 0; i < coursesData.length; i++) {
      for (var j = 0; j < coursesData[i]['cdcList'].length; j++) {
        if (coursesData[i]['cdcList'][j] == branch) {
          for (var k = 0; k < snapshot.data!.length; k++) {
            var data = snapshot.data![k];
            if (data.courseCode == coursesData[i]['courseCode'] &&
                data.courseID == coursesData[i]['courseID']) {
              coursesCount += 1;
            }
          }
        }
      }
    }

    //Asserting the total DEL Courses count
    if (coursesCount.isNaN) {
      coursesCountString = '0';
    } else {
      coursesCountString = coursesCount.toString();
    }

    return coursesCountString;
  }

  String maxCourses(String branch) {
    String maxCoursesString;
    //Total Credits [String] that is returned by the function
    int maxCourses = 0;
    // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
    //Loop to count the total credits from the snapshot of the watchAllCourses Stream

    for (var i = 0; i < coursesData.length; i++) {
      for (var j = 0; j < coursesData[i]['cdcList'].length; j++) {
        if (coursesData[i]['cdcList'][j] == branch) {
          maxCourses += 1;
        }
      }
    }

    //Asserting the total DEL Courses count
    if (maxCourses.isNaN) {
      maxCoursesString = '0';
    } else {
      maxCoursesString = maxCourses.toString();
    }

    return maxCoursesString;
  }

  String maxCredits(String branch) {
    String maxCreditsString;
    //Total Credits [String] that is returned by the function
    int maxCredits = 0;
    // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
    //Loop to count the total credits from the snapshot of the watchAllCourses Stream

    for (var i = 0; i < coursesData.length; i++) {
      for (var j = 0; j < coursesData[i]['cdcList'].length; j++) {
        if (coursesData[i]['cdcList'][j] == branch) {
          maxCredits += int.parse(coursesData[i]['courseCredits']);
        }
      }
    }

    //Asserting the total DEL Courses count
    if (maxCredits.isNaN) {
      maxCreditsString = '0';
    } else {
      maxCreditsString = maxCredits.toString();
    }
    return maxCreditsString;
  }

  List<CourseSimplified> getCompletedCDCCourses(
      AsyncSnapshot<List<Course>> snapshot, String branch) {
    List<CourseSimplified> completedDisciplinaryElectives = [];

    for (var i = 0; i < coursesData.length; i++) {
      for (var j = 0; j < coursesData[i]['cdcList'].length; j++) {
        if (coursesData[i]['cdcList'][j] == branch) {
          for (var k = 0; k < snapshot.data!.length; k++) {
            var data = snapshot.data![k];
            if (data.courseCode == coursesData[i]['courseCode'] &&
                data.courseID == coursesData[i]['courseID']) {
              CourseSimplified newCourse = CourseSimplified(
                courseCode: data.courseCode,
                courseCredits: data.courseCredits.toString(),
                courseID: data.courseID,
                courseTitle: data.courseTitle,
              );
              completedDisciplinaryElectives.add(newCourse);
            }
          }
        }
      }
    }

    return completedDisciplinaryElectives;
  }

  List<CourseSimplified> getMoreCDCCourses(
      AsyncSnapshot<List<Course>> snapshot, String branch) {
    List<CourseSimplified> completedDisciplinaryElectives =
        getCompletedCDCCourses(snapshot, branch);
    List<CourseSimplified> left = [];
    for (var i = 0; i < coursesData.length; i++) {
      for (var j = 0; j < coursesData[i]['cdcList'].length; j++) {
        if (coursesData[i]['cdcList'][j] == branch) {
          bool isCourseCompleted = false;
          for (var k = 0; k < completedDisciplinaryElectives.length; k++) {
            if ((completedDisciplinaryElectives[k].courseCode +
                    completedDisciplinaryElectives[k].courseID) ==
                (coursesData[i]['courseCode'] + coursesData[i]['courseID'])) {
              isCourseCompleted = true;
              break;
            }
          }
          if (!isCourseCompleted) {
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
    print(left.toString());
    return left;
  }
}

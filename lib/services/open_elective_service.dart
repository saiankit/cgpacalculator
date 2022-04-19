import 'package:flutter/material.dart';

import '../data/course_meta_data.dart';
import '../data/courses_data.dart';
import '../models/course_model_simplified.dart';
import 'moor_database_service.dart';

class OpenElectiveService {
  String maxCourses(String primaryDiscipline) {
    return "5";
  }

  String maxCredits(String primaryDiscipline) {
    return "15";
  }

  bool isCourseOpenElective(String courseID, String courseCode, String branch) {
    // If a course is not a Humanity Elective and not a Discipline Elective
    // and not a CDC and not a Common Course then it is an Open Elective
    
    bool isCDC = false;
    bool isDEL = false;

    // Check if the course is a CDC
    labelCDCOutLoop:
    for (var i = 0; i < coursesData.length; i++) {
      if ((coursesData[i]['courseCode'] == courseCode) &&
          (coursesData[i]['courseID'] == courseID)) {
        for (var j = 0; j < coursesData[i]['cdcList'].length; j++) {
          if (coursesData[i]['cdcList'][j] == branch) {
            isCDC = true;
            break labelCDCOutLoop;
          }
        }
      }
    }

    // Check if the course is a DEL
    labelDELOutLoop:
    for (var i = 0; i < coursesData.length; i++) {
      if ((coursesData[i]['courseCode'] == courseCode) &&
          (coursesData[i]['courseID'] == courseID)) {
        for (var j = 0; j < coursesData[i]['delList'].length; j++) {
          if (coursesData[i]['delList'][j] == branch) {
            isDEL = true;
            break labelDELOutLoop;
          }
        }
      }
    }

    bool isCompulsoryCourse = compulsoryCoursesList.any((course) =>
        (course['courseCode'] == courseCode) &&
        (course['courseID'] == courseID));

    bool isHEL = (courseCode == "HSS") || (courseCode == "GS");

    if (!isDEL && !isCDC && !isCompulsoryCourse && !isHEL) return true;

    return false;
  }

  String countCredits(AsyncSnapshot<List<Course>> snapshot, String branch) {
    String totalCredits;
    //Total Credits [String] that is returned by the function
    int creditsCount = 0;

    for (var i = 0; i < snapshot.data!.length; i++) {
      var completedCourse = snapshot.data![i];
      if (isCourseOpenElective(
          completedCourse.courseID, completedCourse.courseCode, branch)) {
        creditsCount += completedCourse.courseCredits;
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
    String coursesCountString;
    //Total Credits [String] that is returned by the function
    int coursesCount = 0;
    // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
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
      if (isCourseOpenElective(
          coursesData[i]['courseID'], coursesData[i]['courseCode'], branch)) {
        bool isCourseCompleted = false;
        for (var j = 0; j < completedOpenElectives.length; j++) {
          if ((completedOpenElectives[j].courseCode +
                  completedOpenElectives[j].courseID) ==
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
    return left;
  }
}

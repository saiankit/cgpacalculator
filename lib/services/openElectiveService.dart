import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/localData/coursesData.dart';
import 'package:CgpaCalculator/localData/departments/departmentExports.dart';
import 'package:CgpaCalculator/services/disciplinaryElectiveService.dart';
import 'package:flutter/material.dart';

class DummyCourseModel {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final String courseCredits;

  DummyCourseModel(
      {this.courseCode, this.courseID, this.courseTitle, this.courseCredits});
}

class OpenElectiveService {
  List<Map<String, dynamic>> getCoreCoursesList(String branch) {
    List<Map<String, dynamic>> coreCoursesList;

    if (branch == 'A1') {
      coreCoursesList = a1CoreCoursesList;
    } else if (branch == 'A2') {
      coreCoursesList = a2CoreCoursesList;
    } else if (branch == 'A3') {
      coreCoursesList = a3CoreCoursesList;
    } else if (branch == 'A4') {
      coreCoursesList = a4CoreCoursesList;
    } else if (branch == 'A5') {
      coreCoursesList = a5CoreCoursesList;
    } else if (branch == 'AA') {
      coreCoursesList = aaCoreCoursesList;
    } else if (branch == 'A7') {
      coreCoursesList = a7CoreCoursesList;
    } else if (branch == 'A8') {
      coreCoursesList = a8CoreCoursesList;
    } else if (branch == 'B1') {
      coreCoursesList = b1CoreCoursesList;
    } else if (branch == 'B2') {
      coreCoursesList = b2CoreCoursesList;
    } else if (branch == 'B3') {
      coreCoursesList = b3CoreCoursesList;
    } else if (branch == 'B4') {
      coreCoursesList = b4CoreCoursesList;
    } else if (branch == 'B5') {
      coreCoursesList = b5CoreCoursesList;
    }
    return coreCoursesList;
  }

  bool isCourseOpenElective(String courseID, String courseCode, String branch) {
    List<Map<String, dynamic>> coreCoursesList = getCoreCoursesList(branch);
    List<Map<String, dynamic>> disciplinaryCoursesList =
        DisciplinaryElectiveService().getBranchSpecificList(branch);
    bool existsDEL = disciplinaryCoursesList.any((course) =>
        (course['courseCode'] == courseCode) &&
        (course['courseID'] == courseID));
    bool existsCore = coreCoursesList.any((course) =>
        (course['courseCode'] == courseCode) &&
        (course['courseID'] == courseID));
    bool existsComp = compulsoryCoursesList.any((course) =>
        (course['courseCode'] == courseCode) &&
        (course['courseID'] == courseID));
    bool existsHEL = (courseCode == "HSS") || (courseCode == "GS");
    if (!existsDEL && !existsCore && !existsComp && !existsHEL) return true;
    return false;
  }

  String countCredits(AsyncSnapshot<List<Course>> snapshot, String branch) {
    String
        totalCredits; //Total Credits [String] that is returned by the function
    int creditsCount = 0;

    for (var i = 0; i < snapshot.data.length; i++) {
      var data = snapshot.data[i];
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
    for (var i = 0; i < snapshot.data.length; i++) {
      var data = snapshot.data[i];
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

  List<DummyCourseModel> getCompletedOpenElecitvesList(
      AsyncSnapshot<List<Course>> snapshot, String branch) {
    List<DummyCourseModel> completedOpenElectives = [];
    for (var i = 0; i < snapshot.data.length; i++) {
      var data = snapshot.data[i];
      if (isCourseOpenElective(data.courseID, data.courseCode, branch)) {
        DummyCourseModel newCourse = DummyCourseModel(
          courseCode: snapshot.data[i].courseCode,
          courseCredits: snapshot.data[i].courseCredits.toString(),
          courseID: snapshot.data[i].courseID,
          courseTitle: snapshot.data[i].courseTitle,
        );
        completedOpenElectives.add(newCourse);
      }
    }

    return completedOpenElectives;
  }

  List<DummyCourseModel> getMoreDisciplinaryElectivesList(
      AsyncSnapshot<List<Course>> snapshot, String branch) {
    List<DummyCourseModel> left = [];
    List<DummyCourseModel> completedOpenElectives =
        getCompletedOpenElecitvesList(snapshot, branch);

    for (var i = 0; i < coursesData.length; i++) {
      for (var j = 0; j < completedOpenElectives.length; j++) {
        if (isCourseOpenElective(
            coursesData[i]['courseID'], coursesData[i]['courseCode'], branch)) {
          if ((completedOpenElectives[j].courseCode +
                  completedOpenElectives[j].courseID) !=
              (coursesData[i]['courseCode'] + coursesData[i]['courseID'])) {
            DummyCourseModel newCourse = DummyCourseModel(
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

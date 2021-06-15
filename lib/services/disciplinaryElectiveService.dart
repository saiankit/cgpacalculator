import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/localData/departments/departmentExports.dart';
import 'package:CgpaCalculator/services/openElectiveService.dart';
import 'package:flutter/material.dart';

class DisciplinaryElectiveService {
  List<Map<String, dynamic>> getBranchSpecificList(String branch) {
    List<Map<String, dynamic>> disciplinaryCoursesList;
    if (branch == 'A1') {
      disciplinaryCoursesList = a1DisciplinaryElectiveList;
    } else if (branch == 'A2') {
      disciplinaryCoursesList = a2DisciplinaryElectiveList;
    } else if (branch == 'A3') {
      disciplinaryCoursesList = a3DisciplinaryElectiveList;
    } else if (branch == 'A4') {
      disciplinaryCoursesList = a4DisciplinaryElectiveList;
    } else if (branch == 'A5') {
      disciplinaryCoursesList = a5DisciplinaryElectiveList;
    } else if (branch == 'AA') {
      disciplinaryCoursesList = aaDisciplinaryElectiveList;
    } else if (branch == 'A7') {
      disciplinaryCoursesList = a7DisciplinaryElectiveList;
    } else if (branch == 'A8') {
      disciplinaryCoursesList = a8DisciplinaryElectiveList;
    } else if (branch == 'B1') {
      disciplinaryCoursesList = b1DisciplinaryElectiveList;
    } else if (branch == 'B2') {
      disciplinaryCoursesList = b2DisciplinaryElectiveList;
    } else if (branch == 'B3') {
      disciplinaryCoursesList = b3DisciplinaryElectiveList;
    } else if (branch == 'B4') {
      disciplinaryCoursesList = b4DisciplinaryElectiveList;
    } else if (branch == 'B5') {
      disciplinaryCoursesList = b5DisciplinaryElectiveList;
    }
    return disciplinaryCoursesList;
  }

  String countCredits(AsyncSnapshot<List<Course>> snapshot, String branch) {
    String
        totalCredits; //Total Credits [String] that is returned by the function
    int creditsCount =
        0; // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
    //Loop to count the total credits from the snapshot of the watchAllCourses Stream
    List<Map<String, dynamic>> disciplinaryCoursesList =
        getBranchSpecificList(branch);

    for (var i = 0; i < snapshot.data.length; i++) {
      var data = snapshot.data[i];
      bool existsDEL = disciplinaryCoursesList.any((course) =>
          (course['courseCode'] == data.courseCode) &&
          (course['courseID'] == data.courseID));
      if (existsDEL) {
        creditsCount += data.courseCredits;
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
    String
        coursesCountString; //Total Credits [String] that is returned by the function
    int coursesCount =
        0; // The loopVariable used to count the credits in completed courses list of the user initialised by the initial credits
    //Loop to count the total credits from the snapshot of the watchAllCourses Stream
    List<Map<String, dynamic>> disciplinaryCoursesList =
        getBranchSpecificList(branch);

    for (var i = 0; i < snapshot.data.length; i++) {
      var data = snapshot.data[i];
      bool existsDEL = disciplinaryCoursesList.any((course) =>
          (course['courseCode'] == data.courseCode) &&
          (course['courseID'] == data.courseID));
      if (existsDEL) {
        coursesCount++;
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

  List<DummyCourseModel> getCompletedDisciplinaryElecitvesList(
      AsyncSnapshot<List<Course>> snapshot, String branch) {
    List<Map<String, dynamic>> disciplinaryCoursesList =
        getBranchSpecificList(branch);
    List<DummyCourseModel> completedDisciplinaryElectives = [];

    for (var i = 0; i < snapshot.data.length; i++) {
      var data = snapshot.data[i];
      bool existsDEL = disciplinaryCoursesList.any((course) =>
          (course['courseCode'] == data.courseCode) &&
          (course['courseID'] == data.courseID));
      if (existsDEL) {
        DummyCourseModel newCourse = DummyCourseModel(
          courseCode: data.courseCode,
          courseCredits: data.courseCredits.toString(),
          courseID: data.courseID,
          courseTitle: data.courseTitle,
        );
        completedDisciplinaryElectives.add(newCourse);
      }
    }
    return completedDisciplinaryElectives;
  }

  List<DummyCourseModel> getMoreDisciplinaryElectivesList(
      AsyncSnapshot<List<Course>> snapshot, String branch) {
    List<Map<String, dynamic>> disciplinaryCoursesList =
        getBranchSpecificList(branch);
    List<DummyCourseModel> completedDisciplinaryElectives =
        getCompletedDisciplinaryElecitvesList(snapshot, 'AA');

    List<DummyCourseModel> left = [];
    for (var i = 0; i < disciplinaryCoursesList.length; i++) {
      for (var j = 0; j < completedDisciplinaryElectives.length; j++) {
        if ((completedDisciplinaryElectives[j].courseCode +
                completedDisciplinaryElectives[j].courseID) !=
            (disciplinaryCoursesList[i]['courseCode'] +
                disciplinaryCoursesList[i]['courseID'])) {
          DummyCourseModel newCourse = DummyCourseModel(
            courseCode: disciplinaryCoursesList[i]['courseCode'],
            courseCredits: disciplinaryCoursesList[i]['courseCredits'],
            courseID: disciplinaryCoursesList[i]['courseID'],
            courseTitle: disciplinaryCoursesList[i]['courseTitle'],
          );
          left.add(newCourse);
        }
      }
    }
    return left;
  }
}

import 'package:cgpacalculator/data/course_meta_data.dart';
import 'package:flutter/material.dart';

import '../models/course_model_simplified.dart';
import 'cdc_service.dart';
import 'disciplinary_elective_service.dart';
import 'humanity_elective_service.dart';
import 'moor_database_service.dart';
import 'open_elective_service.dart';

class ElectiveMapperService {
  Map<int, String> electiveMap = {
    1: 'Humanity Electives',
    2: 'Open Electives',
    3: 'CDC',
    4: 'Disciplinary Electives',
    5: 'CDC',
    6: 'Disciplinary Electives'
  };
  String getCompletedCourses(String primaryDiscipline, int electiveType,
      String secondaryDiscipline, AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService().countCourses(snapshot);
    } else if (electiveType == 2) {
      return OpenElectiveService().countCourses(snapshot, primaryDiscipline);
    } else if (electiveType == 3) {
      return CDCService().countCourses(snapshot, primaryDiscipline);
    } else if (electiveType == 4) {
      return DisciplinaryElectiveService()
          .countCourses(snapshot, primaryDiscipline);
    } else if (electiveType == 5) {
      return CDCService().countCourses(snapshot, secondaryDiscipline);
    } else {
      return DisciplinaryElectiveService()
          .countCourses(snapshot, secondaryDiscipline);
    }
  }

  String getCompletedCredits(String primaryDiscipline, int electiveType,
      String secondaryDiscipline, AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService().countCredits(snapshot);
    } else if (electiveType == 2) {
      return OpenElectiveService().countCredits(snapshot, primaryDiscipline);
    } else if (electiveType == 3) {
      return CDCService().countCredits(snapshot, primaryDiscipline);
    } else if (electiveType == 4) {
      return DisciplinaryElectiveService()
          .countCredits(snapshot, primaryDiscipline);
    } else if (electiveType == 5) {
      return CDCService().countCredits(snapshot, secondaryDiscipline);
    } else {
      return DisciplinaryElectiveService()
          .countCredits(snapshot, secondaryDiscipline);
    }
  }

  String getMaxCourses(String primaryDiscipline, int electiveType,
      String secondaryDiscipline, AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService().maxCourses(primaryDiscipline);
    } else if (electiveType == 2) {
      return OpenElectiveService().maxCourses(primaryDiscipline);
    } else if (electiveType == 3) {
      return CDCService().maxCourses(primaryDiscipline);
    } else if (electiveType == 4) {
      return DisciplinaryElectiveService().maxCourses(primaryDiscipline);
    } else if (electiveType == 5) {
      return CDCService().maxCourses(secondaryDiscipline);
    } else {
      return DisciplinaryElectiveService().maxCourses(secondaryDiscipline);
    }
  }

  String getMaxCredits(String primaryDiscipline, int electiveType,
      String secondaryDiscipline, AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService().maxCredits(primaryDiscipline);
    } else if (electiveType == 2) {
      return OpenElectiveService().maxCredits(primaryDiscipline);
    } else if (electiveType == 3) {
      return CDCService().maxCredits(primaryDiscipline);
    } else if (electiveType == 4) {
      return DisciplinaryElectiveService().maxCredits(primaryDiscipline);
    } else if (electiveType == 5) {
      return CDCService().maxCredits(secondaryDiscipline);
    } else {
      return DisciplinaryElectiveService().maxCredits(secondaryDiscipline);
    }
  }

  List<CourseSimplified> getCompletedList(
      String primaryDiscipline,
      int electiveType,
      String secondaryDiscipline,
      AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService()
          .getCompletedHumanityElecitvesList(snapshot);
    } else if (electiveType == 2) {
      return OpenElectiveService()
          .getCompletedOpenElecitvesList(snapshot, primaryDiscipline);
    } else if (electiveType == 3) {
      return CDCService().getCompletedCDCCourses(snapshot, primaryDiscipline);
    } else if (electiveType == 4) {
      return DisciplinaryElectiveService()
          .getCompletedDisciplinaryElecitvesList(snapshot, primaryDiscipline);
    } else if (electiveType == 5) {
      return CDCService().getCompletedCDCCourses(snapshot, secondaryDiscipline);
    } else {
      return DisciplinaryElectiveService()
          .getCompletedDisciplinaryElecitvesList(snapshot, secondaryDiscipline);
    }
  }

  List<CourseSimplified> getMoreList(String primaryDiscipline, int electiveType,
      String secondaryDiscipline, AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService().getMoreHumanityElecitvesList(snapshot);
    } else if (electiveType == 2) {
      return OpenElectiveService()
          .getMoreOpenElectivesList(snapshot, primaryDiscipline);
    } else if (electiveType == 3) {
      return CDCService().getMoreCDCCourses(snapshot, primaryDiscipline);
    } else if (electiveType == 4) {
      return DisciplinaryElectiveService()
          .getMoreDisciplinaryElectivesList(snapshot, primaryDiscipline);
    } else if (electiveType == 5) {
      return CDCService().getMoreCDCCourses(snapshot, secondaryDiscipline);
    } else {
      return DisciplinaryElectiveService()
          .getMoreDisciplinaryElectivesList(snapshot, secondaryDiscipline);
    }
  }
}

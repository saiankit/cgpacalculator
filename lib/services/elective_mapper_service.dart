import 'package:flutter/material.dart';

import 'cdc_service.dart';
import 'disciplinary_elective_service.dart';
import 'humanity_elective_service.dart';
import 'moor_database_service.dart';
import 'open_elective_service.dart';

class ElectiveMapperService {
  Map<int, String> electiveMap = {
    1: 'Humanity Electives',
    2: 'Disciplinary Electives',
    3: 'Open Electives',
    4: 'CDC'
  };
  String getCompletedCourses(String primaryDiscipline, int electiveType,
      AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService().countCourses(snapshot);
    } else if (electiveType == 2) {
      return DisciplinaryElectiveService()
          .countCourses(snapshot, primaryDiscipline);
    } else if (electiveType == 3) {
      return OpenElectiveService().countCourses(snapshot, primaryDiscipline);
    } else {
      return CDCService().countCourses(snapshot, primaryDiscipline);
    }
  }

  String getCompletedCredits(String primaryDiscipline, int electiveType,
      AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService().countCredits(snapshot);
    } else if (electiveType == 2) {
      return DisciplinaryElectiveService()
          .countCredits(snapshot, primaryDiscipline);
    } else if (electiveType == 3) {
      return OpenElectiveService().countCredits(snapshot, primaryDiscipline);
    } else {
      return CDCService().countCredits(snapshot, primaryDiscipline);
    }
  }

  String getMaxCourses(String primaryDiscipline, int electiveType,
      AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService().maxCourses(primaryDiscipline);
    } else if (electiveType == 2) {
      return DisciplinaryElectiveService().maxCourses(primaryDiscipline);
    } else if (electiveType == 3) {
      return OpenElectiveService().maxCourses(primaryDiscipline);
    } else {
      return CDCService().maxCourses(primaryDiscipline);
    }
  }

  String getMaxCredits(String primaryDiscipline, int electiveType,
      AsyncSnapshot<List<Course>> snapshot) {
    if (electiveType == 1) {
      return HumanityElectiveService().maxCredits(primaryDiscipline);
    } else if (electiveType == 2) {
      return DisciplinaryElectiveService().maxCredits(primaryDiscipline);
    } else if (electiveType == 3) {
      return OpenElectiveService().maxCredits(primaryDiscipline);
    } else {
      return CDCService().maxCredits(primaryDiscipline);
    }
  }
}

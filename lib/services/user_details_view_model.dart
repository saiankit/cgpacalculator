import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/courses_data.dart';

class UserDetails extends ChangeNotifier {
  String sem = '1 - 4';
  String primarDiscipline = 'None';
  String secondaryDiscipline = 'None';
  String minorDiscipline = 'None';
  String id = 'None';
  String manualCGPA = 'None';
  String manualCredits = 'None';
  String manualSem = 'None';

  List<Map<String, dynamic>> coursesDataList = coursesData;

  void update({
    required String courseCode,
    required String courseID,
    required String courseTitle,
    required String courseCredits,
    required List<dynamic> cdcList,
    required List<dynamic> delList,
  }) {
    for (var i = 0; i < coursesDataList.length; i++) {
      if (courseCode == coursesDataList[i]['courseCode'] &&
          courseID == coursesDataList[i]['courseID']) {
        coursesDataList[i]['courseTitle'] = courseTitle;
        coursesDataList[i]['courseCredits'] = courseCredits;
        coursesDataList[i]['courseCode'] = courseCode;
        coursesDataList[i]['courseID'] = courseID;
        coursesDataList[i]['delList'] = delList;
        coursesDataList[i]['cdcList'] = cdcList;
      }
    }
    notifyListeners();
  }

  void onStartUp() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? currsem = _prefs.getString('sem');
    String? cprimaryDiscipline = _prefs.getString('primaryDiscipline');
    String? csecondaryDiscipline = _prefs.getString('secondaryDiscipline');
    String? cminorDiscipline = _prefs.getString('minorDiscipline');
    String? cid = _prefs.getString('id');
    String? cmanualCGPA = _prefs.getString('manualCGPA');
    String? cmanualCredits = _prefs.getString('manualCredits');
    String? cmanualSem = _prefs.getString('manualSem');
    if (cid == null) {
      //Lite No Work
    } else {
      id = cid;
      notifyListeners();
    }
    if (currsem == null) {
      _prefs.setString('sem', '1 - 1');
      sem = '1 - 1';
      notifyListeners();
    } else {
      sem = currsem;
      notifyListeners();
    }

    if (cprimaryDiscipline == null) {
      _prefs.setString('primaryDiscipline', 'None');
      primarDiscipline = 'None';
      notifyListeners();
    } else {
      primarDiscipline = cprimaryDiscipline;
      notifyListeners();
    }
    if (csecondaryDiscipline == null) {
      _prefs.setString('secondaryDiscipline', 'None');
      secondaryDiscipline = 'None';
      notifyListeners();
    } else {
      secondaryDiscipline = csecondaryDiscipline;
      notifyListeners();
    }
    if (cminorDiscipline == null) {
      _prefs.setString('minorDiscipline', 'None');
      minorDiscipline = 'None';
      notifyListeners();
    } else {
      minorDiscipline = cminorDiscipline;
      notifyListeners();
    }
    if (cmanualSem == null) {
      _prefs.setString('manualSem', 'None');
      manualSem = 'None';
      notifyListeners();
    } else {
      manualSem = cmanualSem;
      notifyListeners();
    }
    if (cmanualCredits == null) {
      _prefs.setString('manualCredits', 'None');
      manualCredits = 'None';
      notifyListeners();
    } else {
      manualCredits = cmanualCredits;
      notifyListeners();
    }
    if (cmanualCGPA == null) {
      _prefs.setString('manualCGPA', 'None');
      manualCGPA = 'None';
      notifyListeners();
    } else {
      manualCGPA = cmanualCGPA;
      notifyListeners();
    }
  }

  void changeToSemester(String newSemester) async {
    sem = newSemester;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sem', newSemester);
    notifyListeners();
  }

  void changePrimaryDiscipline(String newDiscipline) async {
    primarDiscipline = newDiscipline;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('primaryDiscipline', primarDiscipline);
    notifyListeners();
  }

  void changeSecondaryDiscipline(String newDiscipline) async {
    secondaryDiscipline = newDiscipline;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('secondaryDiscipline', secondaryDiscipline);
    notifyListeners();
  }

  void changeMinor(String newMinor) async {
    minorDiscipline = newMinor;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('minorDiscipline', minorDiscipline);
    notifyListeners();
  }

  void changeManualCredits(String newManualCredits) async {
    manualCredits = newManualCredits;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('manualCredits', manualCredits);
    notifyListeners();
  }

  void changeManualCGPA(String newManualCGPA) async {
    manualCGPA = newManualCGPA;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('manualCGPA', manualCGPA);
    notifyListeners();
  }

  void changeManualSemester(String newManualSem) async {
    manualSem = newManualSem;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('manualSem', manualSem);
    notifyListeners();
  }
}

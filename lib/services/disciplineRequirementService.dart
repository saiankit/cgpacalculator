import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/localData/departments/departmentExports.dart';
import 'package:CgpaCalculator/services/openElectiveService.dart';
import 'package:flutter/material.dart';

class DisciplineRequirementService {
  int getDelCredits(String branch) {
    int delCredits;
    if (branch == 'A1') {
      delCredits = a1MinDelCourses;
    } else if (branch == 'A2') {
      delCredits = a2MinDelCourses;
    } else if (branch == 'A3') {
      delCredits = a3MinDelCourses;
    } else if (branch == 'A4') {
      delCredits = a4MinDelCourses;
    } else if (branch == 'A5') {
      delCredits = a5MinDelCourses;
    } else if (branch == 'AA') {
      delCredits = aaMinDelCourses;
    } else if (branch == 'A7') {
      delCredits = a7MinDelCourses;
    } else if (branch == 'A8') {
      delCredits = a8MinDelCourses;
    } else if (branch == 'B1') {
      delCredits = b1MinDelCourses;
    } else if (branch == 'B2') {
      delCredits = b2MinDelCourses;
    } else if (branch == 'B3') {
      delCredits = b3MinDelCourses;
    } else if (branch == 'B4') {
      delCredits = b4MinDelCourses;
    } else if (branch == 'B5') {
      delCredits = b5MinDelCourses;
    }
    return delCredits;
  }
}




// Humanities 8 credits 3 courses
// DEL

// Open

// A1 DEL 5 courses 15 creds
// a2, a7, a3, aa, a8, a4, ab, a5,  DEL 4 courses 12 credits
// Only single degree dualites
// b1 15 credits 4 courses
// b2 12 credits 4 courses
// b3 18 credits 6 courses
// b4 15 credits 5 courses
// b5 15 credits 4 courses



// a7 del 4 courses 12 credits


// Total 144 (min) credits

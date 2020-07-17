import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/models/courseDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SemesterState extends ChangeNotifier {
  var selectedSemester = semesterList[0];
  String cummulativeGradePointAverage = "0.00";
  String semesterGradePointAverage = "0.00";

  void sgpaCalculator(String semesterCode) {
    final _firestore = Firestore.instance;
    List total = [];
    List credits = [];
    double sum = 0;
    double cre = 0;
    _firestore
        .collection("users")
        .document(uid)
        .collection(semesterCode)
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        total.add(result["gradeAchieved"] * result["courseCredits"]);
        credits.add(result["courseCredits"]);
      });
    }).then(
      (_) {
        for (int e in total) {
          sum += e;
        }
        for (int e in credits) {
          cre += e;
        }
        double sg = double.parse((sum / cre).toStringAsFixed(2));
        if (sg.isNaN) {
          semesterGradePointAverage = "0.00";
        } else {
          semesterGradePointAverage = sg.toString();
        }
        notifyListeners();
      },
    );
  }

  void changeToSemester(String newSemester) {
    selectedSemester = newSemester;
    sgpaCalculator(selectedSemester);
    notifyListeners();
  }
}

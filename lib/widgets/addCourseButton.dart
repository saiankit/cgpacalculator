import 'package:CgpaCalculator/services/courseInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCourseButton extends StatefulWidget {
  final String semesterCode;
  final String userID;
  final String userName;
  final String courseCode;
  final String courseID;
  final int courseCredits;
  final int gradeAchieved;
  AddCourseButton({
    this.semesterCode,
    this.userID,
    this.userName,
    this.courseCode,
    this.courseID,
    this.courseCredits,
    this.gradeAchieved,
  });
  @override
  _AddCourseButtonState createState() => _AddCourseButtonState();
}

class _AddCourseButtonState extends State<AddCourseButton> {
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _firestore
            .collection('users')
            .document(widget.userID)
            .collection(widget.semesterCode)
            .add({
          'courseCode': '${widget.courseCode}',
          'courseID': '${widget.courseID}',
          'courseCredits': widget.courseCredits,
          'gradeAchieved': widget.gradeAchieved,
          'courseTitle': '${widget.userName}',
        });
        Navigator.pop(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 130.0, top: 28.0),
          child: Text(
            'Add Course',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}

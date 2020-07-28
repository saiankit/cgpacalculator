import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCourseButton extends StatefulWidget {
  final String semesterCode;
  final String userID;
  final String userName;
  final String courseCode;
  final String courseTitle;
  final String courseID;
  final int courseCredits;
  final int gradeAchieved;
  final int documentID;
  UpdateCourseButton({
    this.courseTitle,
    this.semesterCode,
    this.userID,
    this.userName,
    this.courseCode,
    this.courseID,
    this.courseCredits,
    this.gradeAchieved,
    this.documentID,
  });
  @override
  _UpdateCourseButtonState createState() => _UpdateCourseButtonState();
}

class _UpdateCourseButtonState extends State<UpdateCourseButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final courseCode = widget.courseCode;
        final courseID = widget.courseID;
        final semesterCode = widget.semesterCode;
        Provider.of<AppDatabase>(context, listen: false).updateCourse(
          Course(
            userID: widget.userID,
            id: widget.documentID,
            courseCode: courseCode,
            courseID: courseID,
            courseTitle: widget.courseTitle,
            semesterCode: semesterCode,
            courseCredits: widget.courseCredits,
            gradeAchieved: widget.gradeAchieved,
          ),
        );

        Navigator.of(context).pop();
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
            'Update Course',
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

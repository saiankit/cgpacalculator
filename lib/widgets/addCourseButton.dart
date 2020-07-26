import 'package:CgpaCalculator/data/moor_database.dart';
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
  final int documentID;
  final String courseTitle;
  AddCourseButton({
    this.semesterCode,
    this.documentID,
    this.userID,
    this.userName,
    this.courseCode,
    this.courseID,
    this.courseCredits,
    this.gradeAchieved,
    this.courseTitle,
  });
  @override
  _AddCourseButtonState createState() => _AddCourseButtonState();
}

class _AddCourseButtonState extends State<AddCourseButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AppDatabase>(context, listen: false).insertCourse(
          Course(
            id: widget.documentID,
            semesterCode: '${widget.semesterCode}',
            courseCode: '${widget.courseCode}',
            courseID: '${widget.courseID}',
            courseCredits: widget.courseCredits,
            gradeAchieved: widget.gradeAchieved,
            courseTitle: widget.courseTitle.toString(),
          ),
        );
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

import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddCourseButton extends StatefulWidget {
  final BuildContext homeScreenContext;
  final String semesterCode;
  final String userID;
  final String courseCode;
  final String courseID;
  final int courseCredits;
  final int gradeAchieved;
  final int documentID;
  final String courseTitle;
  AddCourseButton({
    this.homeScreenContext,
    this.semesterCode,
    this.documentID,
    this.userID,
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
        HapticFeedback.mediumImpact();
        if (widget.courseTitle == 'Course Not found') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Course Not Found',
                    style: ThemeStyles.marqueeTextStyle),
                content: Text(
                    'Course cannot be added into the journal because it is not found.',
                    style: ThemeStyles.titleTextStyle),
              );
            },
          );
        } else {
          Provider.of<AppDatabase>(context, listen: false).insertCourse(
            Course(
              id: widget.documentID,
              semesterCode: '${widget.semesterCode}',
              courseCode: '${widget.courseCode}',
              courseID: '${widget.courseID}',
              courseCredits: widget.courseCredits,
              gradeAchieved: widget.gradeAchieved,
              courseTitle: widget.courseTitle.toString(),
              userID: widget.userID.toString(),
            ),
          );
          Navigator.pop(context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 130.0, top: 28.0),
          child: Text('Add Course', style: ThemeStyles.addButtonTextStyle),
        ),
      ),
    );
  }
}

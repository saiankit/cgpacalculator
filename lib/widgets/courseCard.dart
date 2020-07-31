import 'package:CgpaCalculator/screens/courseUpdate.dart';
import 'package:CgpaCalculator/services/semesterState.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseCredits;
  final int gradeAchieved;
  final int documentID;
  final String semesterCode;
  final String userID;
  CourseCard({
    this.courseCode,
    this.courseCredits,
    this.gradeAchieved,
    this.courseID,
    this.courseTitle,
    this.documentID,
    this.semesterCode,
    this.userID,
  });
  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SemesterState(),
      child: Consumer<SemesterState>(
        builder: (context, semState, _) => GestureDetector(
          onTap: () {
            search(widget.courseCode, widget.courseID);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.60,
                decoration: ThemeStyles.modalBottomSheetDecoration,
                child: CourseUpdate(
                  courseCode: widget.courseCode,
                  courseGrade: widget.gradeAchieved,
                  courseID: widget.courseID,
                  courseTitle: widget.courseTitle,
                  courseCredits: widget.courseCredits,
                  documentID: widget.documentID,
                  semesterCode: widget.semesterCode,
                  userID: widget.userID,
                ),
              ),
            );
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Container(
              height: 60.0,
              decoration: ThemeStyles.courseCardDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: ThemeStyles.courseCardCourseInfo,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.courseCode,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.courseID,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(left: 10.0),
                      scrollDirection: Axis.horizontal,
                      child: Text(widget.courseTitle,
                          style: ThemeStyles.titleTextStyle),
                    ),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: ThemeStyles.courseCardGradeInfo,
                    child: Center(
                      child: Text(
                        widget.gradeAchieved.toString(),
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

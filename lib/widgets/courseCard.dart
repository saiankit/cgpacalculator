import 'package:CgpaCalculator/screens/courseUpdate.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseCredits;
  final int gradeAchieved;
  CourseCard(
      {this.courseCode,
      this.courseCredits,
      this.gradeAchieved,
      this.courseID,
      this.courseTitle});
  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(30.0),
                topRight: const Radius.circular(30.0),
              ),
            ),
            child: CourseUpdate(
              courseCode: widget.courseCode,
              courseGrade: widget.gradeAchieved,
              courseID: widget.courseID,
              courseTitle: widget.courseTitle,
              courseCredits: widget.courseCredits,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Center(
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
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 10.0),
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.courseTitle,
                      style: ThemeStyles.titleTextStyle,
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      widget.gradeAchieved.toString(),
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            color: Colors.white,
          ),
          height: 60.0,
        ),
      ),
    );
  }
}

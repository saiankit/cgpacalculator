import 'package:CgpaCalculator/screens/courseUpdate.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseGrade;
  CourseCard(
      {this.courseCode, this.courseGrade, this.courseID, this.courseTitle});
  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseUpdate(
              courseCode: widget.courseCode,
              courseGrade: widget.courseGrade,
              courseID: widget.courseID,
              courseTitle: widget.courseTitle,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      widget.courseGrade.toString(),
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

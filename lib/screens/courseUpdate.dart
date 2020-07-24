import 'package:CgpaCalculator/components/gradePointSelector.dart';
import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/models/courseDetails.dart';
import 'package:CgpaCalculator/services/courseInfo.dart';
import 'package:CgpaCalculator/widgets/creditsSelector.dart';
import 'package:CgpaCalculator/widgets/updateCourseButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class CourseUpdate extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseGrade;
  final int courseCredits;
  final int documentID;
  final String semesterCode;
  CourseUpdate(
      {this.courseCode,
      this.courseGrade,
      this.courseID,
      this.courseTitle,
      this.courseCredits,
      this.documentID,
      this.semesterCode});
  @override
  _CourseUpdateState createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
  final _firestore = Firestore.instance;
  Future deleteCourse(String documentID, String semesterCode) async {
    await _firestore
        .collection("users")
        .document(uid)
        .collection(semesterCode)
        .document(documentID)
        .delete();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Course"),
          content: Text("Are you sure you want to delete the course ?"),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Course _course = Course(
                    courseCode: widget.courseCode,
                    courseCredits: widget.courseCredits,
                    courseID: widget.courseID,
                    courseTitle: widget.courseTitle,
                    id: widget.documentID,
                    gradeAchieved: widget.courseGrade,
                    semesterCode: widget.semesterCode,
                  );
                  Provider.of<AppDatabase>(context, listen: false)
                      .deleteCourse(_course);
                  // deleteCourse(widget.documentID, widget.semesterCode);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }),
            FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseInfoState(),
      child: Consumer<CourseInfoState>(builder: (context, courseInfoState, _) {
        // Provider.of<CourseInfoState>(context).changeCourseID(widget.courseID);
        // Provider.of<CourseInfoState>(context)
        //     .changeCourseCode(widget.courseCode);
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 30.0,
                            color: Colors.redAccent,
                          ),
                          onPressed: _showDialog,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CourseCodeSelector(
                          existingCourseCode:
                              Provider.of<CourseInfoState>(context).courseCode,
                          existingCourseID:
                              Provider.of<CourseInfoState>(context).courseID,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Marquee(
                          text: widget.courseTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          blankSpace: 100,
                          velocity: 10,
                        ),
                      ),
                    ),
                  ),
                  CreditSelector(
                    Provider.of<CourseInfoState>(context).selectedCredits,
                  ),
                ],
              ),
              GradePointSelector(),
              UpdateCourseButton(
                courseCode: Provider.of<CourseInfoState>(context).courseCode,
                courseID: Provider.of<CourseInfoState>(context).courseID,
                courseCredits:
                    Provider.of<CourseInfoState>(context).selectedCredits,
                semesterCode: widget.semesterCode,
                documentID: widget.documentID,
                gradeAchieved: widget.courseGrade,
                courseTitle: widget.courseTitle,
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class CourseCodeSelector extends StatefulWidget {
  String existingCourseCode;
  String existingCourseID;
  CourseCodeSelector({this.existingCourseCode, this.existingCourseID});
  @override
  _CourseCodeSelectorState createState() => _CourseCodeSelectorState();
}

class _CourseCodeSelectorState extends State<CourseCodeSelector> {
  changeInfo(String newCourseCode, String newCourseID) {
    Provider.of<CourseInfoState>(context, listen: false)
        .changeCourseID(newCourseID);
    Provider.of<CourseInfoState>(context, listen: false)
        .changeCourseCode(newCourseCode);
  }

  @override
  Widget build(BuildContext context) {
    // changeInfo(widget.existingCourseCode, widget.existingCourseID);
    return Container(
      width: 300.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 60.0,
            width: 140.0,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: DropdownButton<String>(
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                  underline: Container(),
                  value: widget.existingCourseCode,
                  items: courseCodeList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (String value) {
                    print(value);
                    // setState(
                    //   () {
                    //     widget.existingCourseCode = value;
                    //   },
                    // );
                    Provider.of<CourseInfoState>(context, listen: false)
                        .changeCourseCode(value);
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 60.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: DropdownButton<String>(
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                  underline: Container(),
                  value: widget.existingCourseID,
                  items: courseIDList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (String value) {
                    // setState(
                    //   () {
                    //     widget.existingCourseID = value;
                    //   },
                    // );
                    Provider.of<CourseInfoState>(context, listen: false)
                        .changeCourseID(value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

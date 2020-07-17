import 'package:CgpaCalculator/components/gradePointSelector.dart';
import 'package:CgpaCalculator/models/courseDetails.dart';
import 'package:CgpaCalculator/widgets/creditsSelector.dart';
import 'package:CgpaCalculator/widgets/updateCourseButton.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class CourseUpdate extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseGrade;
  final int courseCredits;
  CourseUpdate(
      {this.courseCode,
      this.courseGrade,
      this.courseID,
      this.courseTitle,
      this.courseCredits});
  @override
  _CourseUpdateState createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
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
              onPressed: () => print('Hi'),
            ),
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
    String a = widget.courseCode;
    String _chosenCourseCode = a;
    String _chosenCourseID = widget.courseID;
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
                padding:
                    const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                            value: _chosenCourseCode,
                            items: courseCodeList.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (String value) {
                              setState(
                                () {
                                  _chosenCourseCode = value;
                                },
                              );
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
                            value: _chosenCourseID,
                            items: courseIDList.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (String value) {
                              setState(
                                () {
                                  _chosenCourseID = value;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
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
              CreditSelector(widget.courseCredits),
            ],
          ),
          GradePointSelector(),
          UpdateCourseButton(),
        ],
      ),
    );
  }
}

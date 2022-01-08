import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../../data/course_meta_data.dart';
import '../../data/courses_data.dart';
import '../../services/course_view_model.dart';
import '../../services/moor_database_service.dart';
import '../../services/user_details_view_model.dart';
import '../../utilities/theme_styles.dart';

class CourseUpdate extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseGrade;
  final int courseCredits;
  final int documentID;
  final String semesterCode;
  final String userID;
  CourseUpdate({
    required this.courseCode,
    required this.courseGrade,
    required this.courseID,
    required this.courseTitle,
    required this.courseCredits,
    required this.documentID,
    required this.userID,
    required this.semesterCode,
  });
  @override
  _CourseUpdateState createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
  String _chosenCourseCode = 'CS';
  String _chosenCourseID = 'F111';
  String _courseTitle = 'Computer Programming';
  int _chosenCredits = 4;
  int _chosenGrade = 10;
  String _chosenLetterGrade = 'A';

  searchCourse(String courseCode, String courseID) {
    var res = coursesData
        .where((e) => e['courseCode'] == courseCode)
        .singleWhereOrNull((e) => e['courseID'] == courseID);

    if (res == null) {
      _courseTitle = 'Course Not found';
      _chosenCredits = 1;
    } else {
      _courseTitle = res['courseTitle'];
      _chosenCredits = int.parse(res['courseCredits']);
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        setState(
          () {
            _chosenCourseCode = widget.courseCode;
            _chosenCourseID = widget.courseID;
            _chosenCredits = widget.courseCredits;
            _chosenGrade = widget.courseGrade;
            _courseTitle = widget.courseTitle;
          },
        );
        setState(() {
          _chosenLetterGrade =
              CourseViewModel.mapToLetterGrades(_chosenCredits);
        });
      },
    );
  }

  deleteCourse(Course courseToBeDeleted) {
    Provider.of<AppDatabase>(context, listen: false)
        .deleteCourse(courseToBeDeleted);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Course"),
          content: Text("Are you sure you want to delete the course ?"),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                // Make sure the course that is to be deleted is the course which is selected, not updated one ( because a case might occur where the updated course might not be present in the list)
                Course _courseToBeDeleted = Course(
                  userID: widget.userID,
                  courseCode: widget.courseCode,
                  courseCredits: widget.courseCredits,
                  courseID: widget.courseID,
                  courseTitle: widget.courseTitle,
                  id: widget.documentID,
                  gradeAchieved: widget.courseGrade,
                  semesterCode: widget.semesterCode,
                );
                deleteCourse(_courseToBeDeleted);
                Navigator.of(context).pop(); // Popping the Delete Logout
                Navigator.of(context).pop(); // Popping the Update Course Screen
              },
            ),
            TextButton(
              child: Text("No"),
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
    return Consumer<UserDetails>(
      builder: (context, userDetails, _) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Delete Button - to delete the current course
              Padding(
                padding:
                    EdgeInsets.only(top: Converts.c32, right: Converts.c24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        _showDialog();
                      },
                      child: DeleteCourseButton(),
                    ),
                  ],
                ),
              ),
              // ---------------------------------------------

              // Course Code and ID Selector for updating the course
              // Initialise with the current selected course

              Padding(
                padding:
                    EdgeInsets.only(left: Converts.c16, right: Converts.c16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: Converts.c64,
                      width: Converts.c136,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(Converts.c16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Converts.c8),
                        child: Center(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            style: ThemeStyles.t20TextStyle,
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
                            onChanged: (String? value) {
                              setState(
                                () {
                                  _chosenCourseCode = value!;
                                },
                              );
                              searchCourse(_chosenCourseCode, _chosenCourseID);
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: Converts.c64,
                      width: Converts.c136,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(Converts.c16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Converts.c8),
                        child: Center(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            style: ThemeStyles.t20TextStyle,
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
                            onChanged: (String? value) {
                              setState(
                                () {
                                  _chosenCourseID = value!;
                                },
                              );
                              searchCourse(_chosenCourseCode, _chosenCourseID);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Converts.c16),
                child: Container(
                  height: Converts.c64,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(Converts.c16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Converts.c8),
                    child: Center(
                      child: Marquee(
                        text: _courseTitle,
                        style: ThemeStyles.t20TextStyle,
                        blankSpace: Converts.c96,
                        velocity: Converts.c24,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Converts.c24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Credits', style: ThemeStyles.t16TextStyle),
                        SizedBox(height: Converts.c8),
                        Container(
                          height: Converts.c64,
                          width: Converts.c80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(Converts.c16),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Converts.c8),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Converts.c16),
                              child: Center(
                                child: Text(
                                  _chosenCredits.toString(),
                                  style: ThemeStyles.t20TextStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Grade', style: ThemeStyles.t16TextStyle),
                        SizedBox(height: Converts.c8),
                        Container(
                          height: Converts.c64,
                          width: Converts.c96,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(Converts.c16),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Converts.c16),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down),
                                style: ThemeStyles.t20TextStyle,
                                underline: Container(),
                                value: _chosenLetterGrade,
                                items: gradesList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _chosenLetterGrade = value!;
                                  });
                                  int _chosenNumericGrade =
                                      CourseViewModel.mapToNumberGrades(
                                          _chosenLetterGrade);
                                  setState(() {
                                    _chosenGrade = _chosenNumericGrade;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  if (_courseTitle == 'Course Not found') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Course Not Found',
                              style: ThemeStyles.t20TextStyle),
                          content: Text(
                              'Course cannot be added into the journal because it is not found.',
                              style: ThemeStyles.t16TextStyle),
                        );
                      },
                    );
                  } else {
                    Provider.of<AppDatabase>(context, listen: false)
                        .updateCourse(
                      Course(
                        id: widget.documentID,
                        semesterCode: '${widget.semesterCode}',
                        courseCode: '$_chosenCourseCode',
                        courseID: '$_chosenCourseID',
                        courseCredits: _chosenCredits,
                        gradeAchieved: _chosenGrade,
                        courseTitle: _courseTitle.toString(),
                        userID: widget.userID.toString(),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: Converts.c88,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      'UPDATE COURSE',
                      style: ThemeStyles.t24TextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DeleteCourseButton extends StatelessWidget {
  const DeleteCourseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Converts.c224,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Converts.c8),
        border: Border.all(color: Colors.redAccent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Delete Course',
            style: ThemeStyles.t20TextStyle.copyWith(
              color: Colors.redAccent,
            ),
          ),

          // IconButton is used so that some padding is created by default for the container which looks nice
          IconButton(
            icon: Icon(
              Icons.delete,
              size: Converts.c24,
              color: Colors.redAccent,
            ),
            onPressed: null,
          )
        ],
      ),
    );
  }
}

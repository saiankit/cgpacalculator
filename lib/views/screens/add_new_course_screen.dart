import 'dart:math';

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

class AddCourseScreen extends StatefulWidget {
  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  List<String> courseIDListUpdated = courseIDList;
  String _chosenCourseCode = 'CS';
  String _chosenCourseID = 'F111';
  String _courseTitle = 'Computer Programming';
  int _chosenCredits = 4;
  int _chosenGrade = 10;
  String _chosenLetterGrade = 'A';

  updateDropDownList() {
    Set<String> courseIDdropDownItemsSet = Set<String>();
    for (int i = 0; i < coursesData.length; ++i) {
      if (coursesData[i]['courseCode'] == _chosenCourseCode) {
        courseIDdropDownItemsSet.add(coursesData[i]['courseID']);
      }
    }

    setState(() {
      courseIDListUpdated = [];
      courseIDListUpdated = courseIDdropDownItemsSet.toList();
      _chosenCourseID = courseIDListUpdated[0];
    });
  }

  searchCourse(String courseCode, String courseID) {
    var res = coursesData
        .where((e) => e['courseCode'] == courseCode)
        .singleWhereOrNull((e) => e['courseID'] == courseID);

    if (res == null) {
      setState(() {
        _courseTitle = 'Course Not found';
        _chosenCredits = 1;
      });
    } else {
      setState(() {
        _courseTitle = res['courseTitle'];
        _chosenCredits = int.parse(res['courseCredits']);
      });
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        updateDropDownList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetails>(
      builder: (context, userDetails, _) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: Converts.c40, left: Converts.c16, right: Converts.c16),
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
                                child: Text(value,
                                    style: ThemeStyles.t20TextStyle),
                              );
                            },
                          ).toList(),
                          onChanged: (String? value) {
                            setState(
                              () {
                                _chosenCourseCode = value!;
                              },
                            );
                            updateDropDownList();
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
                          items:
                              courseIDListUpdated.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value,
                                    style: ThemeStyles.t20TextStyle),
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
                            padding:
                                EdgeInsets.symmetric(horizontal: Converts.c16),
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
                        width: Converts.c104,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(Converts.c16),
                        ),
                        child: Center(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Converts.c16),
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
                                    child: Text(value,
                                        style: ThemeStyles.t20TextStyle),
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
                  Provider.of<AppDatabase>(context, listen: false).insertCourse(
                    Course(
                      id: Random().nextInt(10000),
                      semesterCode: '${userDetails.sem}',
                      courseCode: '$_chosenCourseCode',
                      courseID: '$_chosenCourseID',
                      courseCredits: _chosenCredits,
                      gradeAchieved: _chosenGrade,
                      courseTitle: _courseTitle.toString(),
                      userID: userDetails.id.toString(),
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
                    'ADD COURSE',
                    style: ThemeStyles.t24TextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

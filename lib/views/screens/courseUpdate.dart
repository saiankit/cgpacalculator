import 'package:CgpaCalculator/core/routes.dart';
import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/localData/coursesData.dart';
import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:CgpaCalculator/viewModels/courseInfo.dart';
import 'package:CgpaCalculator/views/components/gradeSelector.dart';
import 'package:CgpaCalculator/views/widgets/updateCourseButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import 'homeScreen.dart';

String text = '';
int credits = 1;
searchCourseTitle(String courseCode, String courseID) {
  var res = coursesData
      .where((e) => e['courseCode'] == courseCode)
      .singleWhere((e) => e['courseID'] == courseID, orElse: () => null);
  if (res == null) {
    text = 'Course Not found';
  } else {
    text = res['courseTitle'];
  }
}

searchCourseCredits(String courseCode, String courseID) {
  var res = coursesData
      .where((e) => e['courseCode'] == courseCode)
      .singleWhere((e) => e['courseID'] == courseID, orElse: () => null);
  if (res == null) {
    credits = 1;
  } else {
    credits = int.parse(res['courseCredits']);
  }
}

class CourseUpdate extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseGrade;
  final int courseCredits;
  final int documentID;
  final String semesterCode;
  final String userID;
  CourseUpdate(
      {this.courseCode,
      this.courseGrade,
      this.courseID,
      this.courseTitle,
      this.courseCredits,
      this.documentID,
      this.userID,
      this.semesterCode});
  @override
  _CourseUpdateState createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
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
                Future.delayed(
                    Duration.zero,
                    () =>
                        Navigator.of(context).pop()); // Popping the Home Screen

                navigateToMyApp(context);
              },
            ),
            TextButton(
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
      child: Consumer<CourseInfoState>(
        builder: (context, courseInfoState, _) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          _showDialog();
                        },
                        child: Container(
                          width: 225.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.redAccent),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Delete Course',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 30.0,
                                  color: Colors.redAccent,
                                ),
                                onPressed: null,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TempWidget(
                    existingCourseCode: widget.courseCode,
                    existingCourseID: widget.courseID,
                  ),
                ),
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
                        text: text,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TempCreditSelector(
                        widget.courseCredits,
                      ),
                      TempGradeSelector(widget.courseGrade),
                    ],
                  ),
                ),
                UpdateCourseButton(
                  userID: fuid,
                  courseCode: Provider.of<CourseInfoState>(context).courseCode,
                  courseID: Provider.of<CourseInfoState>(context).courseID,
                  courseCredits:
                      Provider.of<CourseInfoState>(context).selectedCredits,
                  semesterCode: widget.semesterCode,
                  documentID: widget.documentID,
                  gradeAchieved:
                      Provider.of<CourseInfoState>(context).courseGrade,
                  courseTitle: text,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TempGradeSelector extends StatefulWidget {
  final int courseGrade;
  TempGradeSelector(this.courseGrade);
  @override
  _TempGradeSelectorState createState() => _TempGradeSelectorState();
}

class _TempGradeSelectorState extends State<TempGradeSelector> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<CourseInfoState>(context, listen: false)
            .changeGrade(widget.courseGrade);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradeSelector(
        Provider.of<CourseInfoState>(context, listen: false).courseGrade);
  }
}

class TempCreditSelector extends StatefulWidget {
  final int courseCredits;
  TempCreditSelector(this.courseCredits);
  @override
  _TempCreditSelectorState createState() => _TempCreditSelectorState();
}

class _TempCreditSelectorState extends State<TempCreditSelector> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<CourseInfoState>(context, listen: false)
            .changeCredits(widget.courseCredits);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Credits', style: ThemeStyles.marqueeTextStyle),
        SizedBox(height: 10.0),
        Container(
          height: 60.0,
          width: 80.0,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Text(
                  Provider.of<CourseInfoState>(context)
                      .selectedCredits
                      .toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    // return CreditSelector(
    //     Provider.of<CourseInfoState>(context).selectedCredits);
  }
}

class TempWidget extends StatefulWidget {
  final String existingCourseCode;
  final String existingCourseID;
  TempWidget({this.existingCourseCode, this.existingCourseID});
  @override
  _TempWidgetState createState() => _TempWidgetState();
}

class _TempWidgetState extends State<TempWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<CourseInfoState>(context, listen: false)
            .changeCourseCode(widget.existingCourseCode);
        Provider.of<CourseInfoState>(context, listen: false)
            .changeCourseID(widget.existingCourseID);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CourseCodeSelector(
      existingCourseCode:
          Provider.of<CourseInfoState>(context, listen: false).courseCode,
      existingCourseID:
          Provider.of<CourseInfoState>(context, listen: false).courseID,
    );
  }
}

class CourseCodeSelector extends StatefulWidget {
  final String existingCourseCode;
  final String existingCourseID;
  CourseCodeSelector({this.existingCourseCode, this.existingCourseID});
  @override
  _CourseCodeSelectorState createState() => _CourseCodeSelectorState();
}

class _CourseCodeSelectorState extends State<CourseCodeSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Provider.of<CourseInfoState>(context, listen: false)
                        .changeCourseCode(value);
                    searchCourseTitle(
                        value,
                        Provider.of<CourseInfoState>(context, listen: false)
                            .courseID);
                    searchCourseCredits(
                        value,
                        Provider.of<CourseInfoState>(context, listen: false)
                            .courseID);
                    Provider.of<CourseInfoState>(context, listen: false)
                        .changeCredits(credits);
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
                    Provider.of<CourseInfoState>(context, listen: false)
                        .changeCourseID(value);
                    searchCourseTitle(
                        Provider.of<CourseInfoState>(context, listen: false)
                            .courseCode,
                        value);
                    searchCourseCredits(
                        Provider.of<CourseInfoState>(context, listen: false)
                            .courseCode,
                        value);
                    Provider.of<CourseInfoState>(context, listen: false)
                        .changeCredits(credits);
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

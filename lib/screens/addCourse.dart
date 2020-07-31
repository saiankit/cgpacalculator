import 'package:CgpaCalculator/components/gradeSelector.dart';
import 'package:CgpaCalculator/localData/coursesData.dart';
import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/services/courseInfo.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:CgpaCalculator/widgets/addCourseButton.dart';
import 'package:CgpaCalculator/widgets/creditsSelector.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../screens/homeScreen.dart';

class AddCourseScreen extends StatefulWidget {
  final String semesterCode;
  AddCourseScreen(this.semesterCode);
  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  String _chosenCourseCode = 'CS';
  String _chosenCourseID = 'F111';
  String chosenCredits = '4';
  String text = 'Computer Programming';
  search(String courseCode, String courseID) {
    var res = coursesData
        .where((e) => e['courseCode'] == courseCode)
        .singleWhere((e) => e['courseID'] == courseID, orElse: () => null);
    if (res == null) {
      text = 'Course Not found';
    } else {
      text = res['courseTitle'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseInfoState(),
      child: Consumer<CourseInfoState>(
        builder: (context, courseInfoState, _) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
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
                              search(_chosenCourseCode, _chosenCourseID);
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
                              search(_chosenCourseCode, _chosenCourseID);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
                      style: ThemeStyles.marqueeTextStyle,
                      blankSpace: 100,
                      velocity: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CreditSelector(
                      Provider.of<CourseInfoState>(context).selectedCredits,
                    ),
                    GradeSelector(
                        Provider.of<CourseInfoState>(context).courseGrade),
                  ],
                ),
              ),
              AddCourseButton(
                courseTitle: text,
                courseCode: _chosenCourseCode,
                courseID: _chosenCourseID,
                semesterCode: widget.semesterCode,
                userID: fuid,
                courseCredits:
                    Provider.of<CourseInfoState>(context).selectedCredits,
                gradeAchieved:
                    Provider.of<CourseInfoState>(context).courseGrade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/course_meta_data.dart';
import '../../services/user_details_view_model.dart';
import '../../utilities/theme_styles.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String _chosenCourseCode = 'CS';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserDetails>(
        builder: (context, userDetails, _) => Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Converts.c20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(Converts.c16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Converts.c8),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    style: ThemeStyles.t20TextStyle,
                    underline: Container(),
                    value: _chosenCourseCode,
                    items: courseCodeList.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value, style: ThemeStyles.t20TextStyle),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _chosenCourseCode = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  for (var i = 0; i < userDetails.coursesDataList.length; i++) {
                    userDetails.coursesDataList[i]['courseTitle'] = "\'" +
                        userDetails.coursesDataList[i]['courseTitle']
                            .toString() +
                        "\'";
                    userDetails.coursesDataList[i]['courseCredits'] = "\'" +
                        userDetails.coursesDataList[i]['courseCredits']
                            .toString() +
                        "\'";
                    userDetails.coursesDataList[i]['courseCode'] = "\'" +
                        userDetails.coursesDataList[i]['courseCode']
                            .toString() +
                        "\'";
                    userDetails.coursesDataList[i]['courseID'] = "\'" +
                        userDetails.coursesDataList[i]['courseID'].toString() +
                        "\'";

                    for (var j = 0;
                        j < userDetails.coursesDataList[i]['delList'].length;
                        j++) {
                      userDetails.coursesDataList[i]['delList'][j] = "\'" +
                          userDetails.coursesDataList[i]['delList'][j]
                              .toString() +
                          "\'";
                    }

                    for (var j = 0;
                        j < userDetails.coursesDataList[i]['cdcList'].length;
                        j++) {
                      userDetails.coursesDataList[i]['cdcList'][j] = "\'" +
                          userDetails.coursesDataList[i]['cdcList'][j]
                              .toString() +
                          "\'";
                    }
                  }
                  log(userDetails.coursesDataList.toString());
                },
                child: Text('SAVE')),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: userDetails.coursesDataList
                    .where(
                        (element) => element['courseCode'] == _chosenCourseCode)
                    .toList()
                    .length,
                itemBuilder: (context, index) {
                  return CourseCard(
                    courseCode: userDetails.coursesDataList
                        .where((element) =>
                            element['courseCode'] == _chosenCourseCode)
                        .toList()[index]['courseCode'],
                    courseCredits: userDetails.coursesDataList
                        .where((element) =>
                            element['courseCode'] == _chosenCourseCode)
                        .toList()[index]['courseCredits'],
                    courseID: userDetails.coursesDataList
                        .where((element) =>
                            element['courseCode'] == _chosenCourseCode)
                        .toList()[index]['courseID'],
                    courseTitle: userDetails.coursesDataList
                        .where((element) =>
                            element['courseCode'] == _chosenCourseCode)
                        .toList()[index]['courseTitle'],
                    cdcList: userDetails.coursesDataList
                        .where((element) =>
                            element['courseCode'] == _chosenCourseCode)
                        .toList()[index]['cdcList'],
                    delList: userDetails.coursesDataList
                        .where((element) =>
                            element['courseCode'] == _chosenCourseCode)
                        .toList()[index]['delList'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final String courseCredits;
  final List<dynamic> cdcList;
  final List<dynamic> delList;
  const CourseCard({
    Key? key,
    required this.courseCode,
    required this.courseID,
    required this.courseTitle,
    required this.courseCredits,
    required this.cdcList,
    required this.delList,
  }) : super(key: key);

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Converts.c20, vertical: Converts.c8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EditScreen(
                  courseCode: widget.courseCode,
                  courseCredits: widget.courseCredits,
                  courseID: widget.courseID,
                  courseTitle: widget.courseTitle,
                  cdcList: widget.cdcList,
                  delList: widget.delList,
                );
              },
            ),
          );
        },
        child: Container(
          height: Converts.c64,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(Converts.c8),
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: Converts.c64,
                width: Converts.c64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Converts.c8),
                  color: Colors.black,
                ),
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
                  padding: EdgeInsets.only(left: Converts.c8),
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.courseTitle,
                    style: ThemeStyles.t16TextStyle
                        .copyWith(color: Colors.grey[600]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditScreen extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final String courseCredits;
  final List<dynamic> cdcList;
  final List<dynamic> delList;

  const EditScreen({
    Key? key,
    required this.courseCode,
    required this.courseID,
    required this.courseTitle,
    required this.courseCredits,
    required this.cdcList,
    required this.delList,
  }) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final courseCodeController = TextEditingController();
  final courseIDController = TextEditingController();
  final courseTitleController = TextEditingController();
  final courseCreditsController = TextEditingController();
  List<dynamic> branchCodes = [
    'A1',
    'A2',
    'A3',
    'A4',
    'A5',
    'AA',
    'A7',
    'A8',
    'B1',
    'B2',
    'B3',
    'B4',
    'B5',
  ];
  List<dynamic> cdcList = [];
  List<dynamic> delList = [];

  @override
  void initState() {
    super.initState();
    courseCodeController.text = widget.courseCode;
    courseCreditsController.text = widget.courseCredits;
    courseIDController.text = widget.courseID;
    courseTitleController.text = widget.courseTitle;
    cdcList = widget.cdcList;
    delList = widget.delList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(Converts.c24),
        child: ListView(
          children: [
            TextField(
              controller: courseCodeController,
              decoration: const InputDecoration(
                hintText: 'Course Code',
              ),
            ),
            SizedBox(height: Converts.c12),
            TextField(
              controller: courseCreditsController,
              decoration: const InputDecoration(
                hintText: 'Course Code',
              ),
            ),
            SizedBox(height: Converts.c12),
            TextField(
              controller: courseIDController,
              decoration: const InputDecoration(
                hintText: 'Course Code',
              ),
            ),
            SizedBox(height: Converts.c12),
            TextField(
              controller: courseTitleController,
              decoration: const InputDecoration(
                hintText: 'Course Code',
              ),
            ),
            SizedBox(height: Converts.c12),
            Text('CDC'),
            SizedBox(height: Converts.c12),
            Wrap(
                children: branchCodes.map((value) {
              return Container(
                padding: EdgeInsets.all(Converts.c8),
                child: ChoiceChip(
                  selectedColor: Colors.lightBlueAccent,
                  label: Padding(
                    padding: EdgeInsets.all(Converts.c12),
                    child: Text(value, style: ThemeStyles.t20TextStyle),
                  ),
                  selected: cdcList.contains(value),
                  onSelected: (selected) {
                    setState(
                      () {
                        cdcList.contains(value)
                            ? cdcList.remove(value)
                            : cdcList.add(value);
                      },
                    );
                    log(cdcList.toString());
                  },
                ),
              );
            }).toList()),
            SizedBox(height: Converts.c12),
            Text('DEL'),
            SizedBox(height: Converts.c12),
            Wrap(
                children: branchCodes.map((value) {
              return Container(
                padding: EdgeInsets.all(Converts.c8),
                child: ChoiceChip(
                  selectedColor: Colors.lightBlueAccent,
                  label: Padding(
                    padding: EdgeInsets.all(Converts.c12),
                    child: Text(value, style: ThemeStyles.t20TextStyle),
                  ),
                  selected: delList.contains(value),
                  onSelected: (selected) {
                    setState(
                      () {
                        delList.contains(value)
                            ? delList.remove(value)
                            : delList.add(value);
                      },
                    );
                  },
                ),
              );
            }).toList()),
            SizedBox(height: Converts.c12),
            Consumer<UserDetails>(
              builder: (context, userDetails, _) => ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  userDetails.update(
                    courseCode: courseCodeController.text,
                    courseID: courseIDController.text,
                    courseTitle: courseTitleController.text,
                    courseCredits: courseCreditsController.text,
                    cdcList: cdcList,
                    delList: delList,
                  );

                  Navigator.of(context).pop();
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

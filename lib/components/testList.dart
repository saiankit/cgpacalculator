import 'package:CgpaCalculator/widgets/courseCard.dart';
import 'package:flutter/material.dart';

class TestList extends StatefulWidget {
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        CourseCard(
          courseCode: 'BIO',
          courseID: 'F110',
          courseTitle: 'Test',
          courseGrade: 10,
        ),
        CourseCard(
          courseCode: 'BIO',
          courseID: 'F111',
          courseTitle: 'Test',
          courseGrade: 9,
        ),
        CourseCard(
          courseCode: 'BITS',
          courseID: 'F110',
          courseTitle: 'Engineering Graphics',
          courseGrade: 10,
        ),
        CourseCard(
          courseCode: 'BITS',
          courseID: 'F111',
          courseTitle: 'Thermodynamics',
          courseGrade: 8,
        ),
        CourseCard(
          courseCode: 'BITS',
          courseID: 'F112',
          courseTitle: 'Technical Report Writing',
          courseGrade: 8,
        ),
        CourseCard(
          courseCode: 'CS',
          courseID: 'F111',
          courseTitle: 'Computer Programming',
          courseGrade: 8,
        ),
        CourseCard(
          courseCode: 'MATH',
          courseID: 'F111',
          courseTitle: 'Mathematics 1',
          courseGrade: 7,
        )
      ],
    );
  }
}

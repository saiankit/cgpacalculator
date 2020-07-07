import 'package:CgpaCalculator/widgets/courseCard.dart';
import 'package:flutter/material.dart';

class CoursesList extends StatefulWidget {
  @override
  _CoursesListState createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        CourseCard(
          courseCode: 'BIO',
          courseID: 'F110',
          courseTitle: 'Biology Laboratory',
          courseGrade: 10,
        ),
        CourseCard(
          courseCode: 'BIO',
          courseID: 'F111',
          courseTitle: 'General Biology',
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

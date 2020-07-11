import 'package:CgpaCalculator/data/courses.dart';
import 'package:CgpaCalculator/widgets/courseCard.dart';
import 'package:flutter/material.dart';

class CoursesList extends StatefulWidget {
  @override
  _CoursesListState createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) => CourseCard(
          courseCode: courses[index].courseCode,
          gradeAchieved: courses[index].courseGrade,
          courseID: courses[index].courseID,
          courseTitle: courses[index].courseTitle,
        ),
      ),
    );
  }
}

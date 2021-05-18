import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';

class AddAnewCourseButton extends StatefulWidget {
  @override
  _AddAnewCourseButtonState createState() => _AddAnewCourseButtonState();
}

class _AddAnewCourseButtonState extends State<AddAnewCourseButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 20.0),
      child: Container(
        height: 60.0,
        decoration: ThemeStyles.addNewCourse,
        child: Padding(
          padding: EdgeInsets.only(left: 30.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Add a new Course',
                style: ThemeStyles.titleTextStyle,
              ),
              Icon(Icons.add, color: Colors.grey[600]),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:CgpaCalculator/viewModels/courseInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradePointCard extends StatefulWidget {
  final String grade;
  GradePointCard(this.grade);
  @override
  _GradePointCardState createState() => _GradePointCardState();
}

class _GradePointCardState extends State<GradePointCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            _isSelected = !_isSelected;
          },
        );
        switch (widget.grade) {
          case 'A':
            Provider.of<CourseInfoState>(context, listen: false)
                .changeGrade(10);
            break;
          case 'A-':
            Provider.of<CourseInfoState>(context, listen: false).changeGrade(9);
            break;
          case 'B':
            Provider.of<CourseInfoState>(context, listen: false).changeGrade(8);
            break;
          case 'B-':
            Provider.of<CourseInfoState>(context, listen: false).changeGrade(7);
            break;
          case 'C':
            Provider.of<CourseInfoState>(context, listen: false).changeGrade(6);
            break;
          case 'C-':
            Provider.of<CourseInfoState>(context, listen: false).changeGrade(5);
            break;
          case 'D':
            Provider.of<CourseInfoState>(context, listen: false).changeGrade(4);
            break;
          case 'E':
            Provider.of<CourseInfoState>(context, listen: false).changeGrade(3);
            break;
          default:
            Provider.of<CourseInfoState>(context, listen: false)
                .changeGrade(10);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: _isSelected
                ? Colors.greenAccent
                : Color(0xFFC4C4C4).withOpacity(0.2),
          ),
          child: Center(
            child: Text(
              widget.grade,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 21.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

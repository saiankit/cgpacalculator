import 'package:CgpaCalculator/widgets/gradePointCard.dart';
import 'package:flutter/material.dart';

class GradePointSelector extends StatefulWidget {
  @override
  _GradePointSelectorState createState() => _GradePointSelectorState();
}

class _GradePointSelectorState extends State<GradePointSelector> {
  List<bool> _isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            GradePointCard('A'),
            GradePointCard('A-'),
            GradePointCard('B'),
            GradePointCard('B-'),
          ],
        ),
        Row(
          children: <Widget>[
            GradePointCard('C'),
            GradePointCard('C-'),
            GradePointCard('D'),
            GradePointCard('E'),
          ],
        )
      ],
    );
  }
}

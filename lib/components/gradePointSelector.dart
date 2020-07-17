import 'package:CgpaCalculator/widgets/gradePointCard.dart';
import 'package:flutter/material.dart';

class GradePointSelector extends StatefulWidget {
  @override
  _GradePointSelectorState createState() => _GradePointSelectorState();
}

class _GradePointSelectorState extends State<GradePointSelector> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GradePointCard('A'),
            GradePointCard('A-'),
            GradePointCard('B'),
            GradePointCard('B-'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
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

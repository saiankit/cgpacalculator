import 'package:flutter/material.dart';

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
        setState(() {
          _isSelected = !_isSelected;
        });
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

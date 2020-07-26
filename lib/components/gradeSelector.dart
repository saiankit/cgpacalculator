import 'package:CgpaCalculator/services/courseInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GradeSelector extends StatefulWidget {
  int courseGrade;
  GradeSelector(this.courseGrade);
  @override
  _GradeSelectorState createState() => _GradeSelectorState();
}

class _GradeSelectorState extends State<GradeSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Grade',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 20),
          Container(
            height: 60.0,
            width: 80.0,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: DropdownButton<int>(
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                  underline: Container(),
                  value: widget.courseGrade,
                  items: [10, 9, 8, 7, 6, 5, 4, 2].map<DropdownMenuItem<int>>(
                    (int value) {
                      return DropdownMenuItem(
                        value: value.toInt(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (int value) {
                    setState(
                      () {
                        widget.courseGrade = value;
                      },
                    );
                    Provider.of<CourseInfoState>(context, listen: false)
                        .changeGrade(value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

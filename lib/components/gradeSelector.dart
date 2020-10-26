import 'package:CgpaCalculator/providerStates/courseInfo.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
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
  mapGrades(String letterGrade) {
    int numericalGrade = 10;
    switch (letterGrade) {
      case "A":
        {
          numericalGrade = 10;
        }
        break;

      case "A-":
        {
          numericalGrade = 9;
        }
        break;
      case "B":
        {
          numericalGrade = 8;
        }
        break;
      case "B-":
        {
          numericalGrade = 7;
        }
        break;
      case "C":
        {
          numericalGrade = 6;
        }
        break;
      case "C-":
        {
          numericalGrade = 5;
        }
        break;
      case "D":
        {
          numericalGrade = 4;
        }
        break;
      case "E":
        {
          numericalGrade = 2;
        }
        break;

      default:
        {
          numericalGrade = 10;
        }
        break;
    }
    return numericalGrade;
  }

  mapToNumberGrades(int numericalGrade) {
    String letterGrade = "A";
    switch (numericalGrade) {
      case 10:
        {
          letterGrade = "A";
        }
        break;

      case 9:
        {
          letterGrade = "A-";
        }
        break;
      case 8:
        {
          letterGrade = "B";
        }
        break;
      case 7:
        {
          letterGrade = "B-";
        }
        break;
      case 6:
        {
          letterGrade = "C";
        }
        break;
      case 5:
        {
          letterGrade = "C-";
        }
        break;
      case 4:
        {
          letterGrade = "D";
        }
        break;
      case 2:
        {
          letterGrade = "E";
        }
        break;

      default:
        {
          letterGrade = "A";
        }
        break;
    }
    return letterGrade;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Grade', style: ThemeStyles.marqueeTextStyle),
        SizedBox(height: 10.0),
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
              child: DropdownButton<String>(
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
                underline: Container(),
                value: mapToNumberGrades(widget.courseGrade),
                items: ["A", "A-", "B", "B-", "C", "C-", "D", "E"]
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (String value) {
                  setState(
                    () {
                      widget.courseGrade = mapGrades(value);
                    },
                  );
                  Provider.of<CourseInfoState>(context, listen: false)
                      .changeGrade(mapGrades(value));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

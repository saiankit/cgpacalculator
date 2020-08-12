import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/services/calculation.dart';
import 'package:CgpaCalculator/services/semesterState.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorRow extends StatefulWidget {
  final String fuid;
  final BuildContext homeScreenContext;
  CalculatorRow({this.fuid, this.homeScreenContext});
  @override
  _CalculatorRowState createState() => _CalculatorRowState();
}

class _CalculatorRowState extends State<CalculatorRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text('SGPA', style: ThemeStyles.gpaTextStyle),
              ),
              StreamBuilder(
                stream: Provider.of<AppDatabase>(widget.homeScreenContext)
                    .watchCoursesBySemesterCode(
                        Provider.of<SemesterState>(widget.homeScreenContext)
                            .selectedSemester,
                        widget.fuid),
                builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child:
                          Text('0.00', style: ThemeStyles.gpaNumberTextStyle),
                    );
                  String sGPA = calculateGPA(snapshot);
                  return Text(sGPA, style: ThemeStyles.gpaNumberTextStyle);
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text('CGPA', style: ThemeStyles.gpaTextStyle),
              ),
              StreamBuilder(
                stream: Provider.of<AppDatabase>(widget.homeScreenContext)
                    .watchAllCourses(widget.fuid),
                builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child:
                          Text('0.00', style: ThemeStyles.gpaNumberTextStyle),
                    );
                  String cGPA = calculateGPA(snapshot);
                  return Text(cGPA, style: ThemeStyles.gpaNumberTextStyle);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

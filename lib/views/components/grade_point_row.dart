import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/grade_point_calculator.dart';
import '../../services/moor_database_service.dart';
import '../../services/user_details_view_model.dart';
import '../../utilities/theme_styles.dart';

class GradePointUI extends StatefulWidget {
  @override
  _GradePointUIState createState() => _GradePointUIState();
}

class _GradePointUIState extends State<GradePointUI> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserDetails>(context, listen: false).onStartUp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetails>(builder: (context, userDetails, snapshot) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: Converts.c16),
                child: Text(
                  'SGPA',
                  style: ThemeStyles.t16TextStyle,
                ),
              ),
              StreamBuilder(
                stream: Provider.of<AppDatabase>(context)
                    .watchCoursesBySemesterCode(
                        userDetails.sem, userDetails.id),
                builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Text(
                        '0.00',
                        style: ThemeStyles.t40TextStyle,
                      ),
                    );
                  String sGPA = calculateGPA(snapshot);
                  return Text(
                    sGPA,
                    style: ThemeStyles.t40TextStyle,
                  );
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: Converts.c16),
                child: Text(
                  'CGPA',
                  style: ThemeStyles.t16TextStyle,
                ),
              ),
              StreamBuilder(
                stream: Provider.of<AppDatabase>(context)
                    .watchAllCourses(userDetails.id),
                builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Text(
                        '0.00',
                        style: ThemeStyles.t40TextStyle,
                      ),
                    );
                  String sGPA = calculateCGPA(snapshot, userDetails.manualCGPA,
                      userDetails.manualCredits);
                  return Text(
                    sGPA,
                    style: ThemeStyles.t40TextStyle,
                  );
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}

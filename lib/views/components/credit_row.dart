import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/credits_calculator.dart';
import '../../services/moor_database_service.dart';
import '../../services/user_details_view_model.dart';
import '../../utilities/theme_styles.dart';

class CreditRow extends StatelessWidget {
  const CreditRow({Key? key}) : super(key: key);

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
                  'Credits',
                  style: ThemeStyles.t12TextStyle,
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
                        '0',
                        style: ThemeStyles.t24TextStyle,
                      ),
                    );
                  String totalCredits = countSemCredits(snapshot);
                  return Text(
                    totalCredits,
                    style: ThemeStyles.t24TextStyle,
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
                  'Credits',
                  style: ThemeStyles.t12TextStyle,
                ),
              ),
              StreamBuilder(
                stream: Provider.of<AppDatabase>(context)
                    .watchAllCourses(userDetails.id),
                builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Text(
                        '0',
                        style: ThemeStyles.t24TextStyle,
                      ),
                    );
                  String totalCredits = countAllCredits(snapshot);
                  return Text(
                    totalCredits,
                    style: ThemeStyles.t24TextStyle,
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

import 'package:CgpaCalculator/core/routes.dart';
import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/viewModels/courseInfo.dart';
import 'package:CgpaCalculator/views/screens/settingsScreen.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appbar extends StatefulWidget {
  final String fuid;
  final BuildContext homeScreenContext;

  const Appbar({Key key, this.homeScreenContext, this.fuid}) : super(key: key);
  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                height: 45,
                width: 110,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Consumer<CourseInfoState>(
                  builder: (context, courseInfoState, _) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                      underline: Container(),
                      value: courseInfoState.selectedSemester,
                      items: semesterList.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (String value) {
                        courseInfoState.changeToSemester(value);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.analytics,
                size: 30.0,
                color: Colors.black,
              ),
              onPressed: () {
                navigateToAnalyticsScreen(
                    context, widget.homeScreenContext, widget.fuid);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                size: 30.0,
                color: Colors.black,
              ),
              onPressed: () {
                navigateToSettingsScreen(
                    context, widget.homeScreenContext, widget.fuid);
              },
            )
          ],
        )
      ],
    );
  }
}

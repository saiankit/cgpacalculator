import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../data/course_meta_data.dart';
import '../../services/user_details_view_model.dart';
import '../../utilities/theme_styles.dart';
import '../screens/analytics_screen.dart';
import '../screens/settings_screen.dart';

class Appbar extends StatelessWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: Converts.c48,
              width: Converts.c112,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(Converts.c16),
              ),
              child: Consumer<UserDetails>(
                builder: (context, courseInfoState, _) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: Converts.c8),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    style: ThemeStyles.t20TextStyle,
                    underline: Container(),
                    value: courseInfoState.sem,
                    items: semesterList.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      courseInfoState.changeToSemester(value!);
                    },
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
                size: Converts.c32,
                color: Colors.black,
              ),
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AnalyticsScreen();
                    },
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                size: Converts.c32,
                color: Colors.black,
              ),
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsScreen();
                    },
                  ),
                );
              },
            )
          ],
        )
      ],
    );
  }
}

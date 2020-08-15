import 'package:CgpaCalculator/core/routes.dart';
import 'package:CgpaCalculator/data/hive_api.dart';
import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/providerStates/courseInfo.dart';
import 'package:CgpaCalculator/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appbar extends StatefulWidget {
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
                child: Padding(
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
                    value:
                        Provider.of<CourseInfoState>(context).selectedSemester,
                    items: semesterList.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (String value) {
                      Provider.of<CourseInfoState>(context, listen: false)
                          .changeToSemester(value);
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
                Icons.open_in_browser,
                size: 30.0,
                color: Colors.black,
              ),
              onPressed: () {
                navigateToManualEntryScreen(context);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.power_settings_new,
                size: 30.0,
                color: Colors.redAccent,
              ),
              onPressed: () => showLogOutDialog(context),
            ),
          ],
        )
      ],
    );
  }
}

void showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout from the App ?"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Yes',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () async {
              await authService.signOutGoogle();
              hiveDeleteData();
              syncPrefs.setString('uid', null).then(
                (value) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  navigateToMyApp(context);
                },
              );
            },
          ),
          FlatButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

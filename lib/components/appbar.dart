import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/providerStates/courseInfo.dart';
import 'package:CgpaCalculator/screens/manualEntry.dart';
import 'package:CgpaCalculator/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appbar extends StatefulWidget {
  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  void _showAddCGdialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add CGPA until particular semester"),
          content: Text(
              "Are you sure you want to add CGPA until a particular semester ?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await authService.signOutGoogle();
                prefs.clear().then(
                  (value) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ManualEntry();
                        },
                      ),
                    );
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

  void _showLogOutDialog() {
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
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await authService.signOutGoogle();
                prefs.clear().then(
                  (value) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return MyApp(prefs.getString('uid'));
                        },
                      ),
                    );
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
                Icons.add,
                size: 30.0,
                color: Colors.black,
              ),
              onPressed: () => _showAddCGdialog(),
            ),
            IconButton(
              icon: Icon(
                Icons.power_settings_new,
                size: 30.0,
                color: Colors.redAccent,
              ),
              onPressed: () => _showLogOutDialog(),
            ),
          ],
        )
      ],
    );
  }
}

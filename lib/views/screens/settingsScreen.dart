import 'package:CgpaCalculator/core/routes.dart';
import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/utilities/icons.dart';
import 'package:CgpaCalculator/viewModels/courseInfo.dart';
import 'package:flutter/material.dart';
import 'package:CgpaCalculator/data/hive_api.dart';
import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  final String fuid;
  final BuildContext homeScreenContext;

  const SettingsScreen({Key key, this.fuid, this.homeScreenContext})
      : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
       leading: IconButton(
          icon: CustomIcons.arrowBackIOS,
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<CourseInfoState>(
          builder: (context, courseInfoState, _) => Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: Icon(Icons.book),
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            'Discipline',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(width: 20.0),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Container(
                          height: 45,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                              value: courseInfoState.primaryDiscipline,
                              items: primaryDisciplineList
                                  .map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String value) {
                                courseInfoState.changePrimaryDiscipline(value);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 35.0, vertical: 10.0),
                child: Row(
                  children: [
                    Text(
                      'Dual Discipline',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Transform.scale(
                      scale: 0.75,
                      child: Switch(
                        onChanged: (_) {
                          HapticFeedback.mediumImpact();
                          courseInfoState.toggleSecondaryDiscipline();
                        },
                        value: courseInfoState.secondaryDisciplineExists,
                        activeColor: Colors.black,
                        activeTrackColor: Colors.black,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
              if (courseInfoState.secondaryDisciplineExists == true)
                AnimatedContainer(
                  duration: Duration(seconds: 2),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                child: Icon(Icons.book),
                              ),
                              SizedBox(width: 20.0),
                              Text(
                                'Dual Discipline',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              height: 45,
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                  value: courseInfoState.secondaryDiscipline,
                                  items: secondaryDisciplineList
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String value) {
                                    courseInfoState
                                        .changeSecondaryDiscipline(value);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 35.0, vertical: 10.0),
                child: Row(
                  children: [
                    Text(
                      'Minor Discipline',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Transform.scale(
                      scale: 0.75,
                      child: Switch(
                        onChanged: (_) {
                          HapticFeedback.mediumImpact();
                          courseInfoState.toggleMinor();
                        },
                        value: courseInfoState.minorExists,
                        activeColor: Colors.black,
                        activeTrackColor: Colors.black,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
              if (courseInfoState.minorExists)
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              child: Icon(Icons.book),
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              'Minor',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Container(
                            height: 45,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                ),
                                underline: Container(),
                                value: courseInfoState.minor,
                                items: minorList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String value) {
                                  courseInfoState.changeMinor(value);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  navigateToManualEntryScreen(context);
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              child: Icon(Icons.open_in_browser),
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              'Manual Entry',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(width: 20.0),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.1),
                          ),
                          child: Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  navigateToAnalyticsScreen(
                      context, widget.homeScreenContext, widget.fuid);
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              child: Icon(
                                Icons.analytics,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              'Analytics',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(width: 20.0),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.1),
                          ),
                          child: Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  showLogOutDialog(context);
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              child: Icon(
                                Icons.power_settings_new,
                                size: 30.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              'Log Out',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(width: 20.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
          TextButton(
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
                  Navigator.of(context).pop();
                  navigateToMyApp(context);
                },
              );
            },
          ),
          TextButton(
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

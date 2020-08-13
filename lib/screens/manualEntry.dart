import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/providerStates/courseInfo.dart';
import 'package:CgpaCalculator/services/auth.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManualEntry extends StatefulWidget {
  @override
  _ManualEntryState createState() => _ManualEntryState();
}

class _ManualEntryState extends State<ManualEntry> {
  String cgpa;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.00,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CourseInfoState(),
        child: Consumer<CourseInfoState>(
          builder: (context, courseInfoState, _) => Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Semester until which manual CG is being entered',
                        style: ThemeStyles.marqueeTextStyle,
                      ),
                      Container(
                        height: 60.0,
                        width: 100.0,
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
                              value: Provider.of<CourseInfoState>(context)
                                  .defaultSemesterManual,
                              items: semesterList.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String value) {
                                Provider.of<CourseInfoState>(context,
                                        listen: false)
                                    .changeManualSemester(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    onChanged: (String value) {
                      setState(() {
                        cgpa = value;
                      });
                      Provider.of<CourseInfoState>(context, listen: false)
                          .changeManualCG(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText:
                          "Enter CGPA until  ${Provider.of<CourseInfoState>(context, listen: false).defaultSemesterManual}",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    onChanged: (String value) {
                      setState(() {
                        cgpa = value;
                      });
                      Provider.of<CourseInfoState>(context, listen: false)
                          .changeManualCredits(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText:
                          "Enter credits exhausted until  ${Provider.of<CourseInfoState>(context).defaultSemesterManual}",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String man =
                        Provider.of<CourseInfoState>(context, listen: false)
                            .manualExhaust;
                    prefs.setString('manualCredits', man).then(
                      (value) {
                        // setState(() {
                        //   isLoading = false;
                        // });
                        String manualCG =
                            Provider.of<CourseInfoState>(context, listen: false)
                                .manualEntryCG;
                        prefs.setString('manualCG', manualCG);
                      },
                    ).then(
                      (value) {
                        String manualAddSem =
                            Provider.of<CourseInfoState>(context, listen: false)
                                .defaultSemesterManual;
                        prefs.setString('manualSem', manualAddSem);
                      },
                    ).then(
                      (value) {
                        prefs.setString('uid', authService.id).then(
                          (value) {
                            String userID = prefs.getString('uid');
                            Navigator.of(context)
                                .pop(); // Pop out the Manual Entry Screen
                            Navigator.of(context)
                                .pop(); // Pop out the Home Screen
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return MyApp(userID);
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 130.0, top: 28.0),
                      child: Text('Add Course',
                          style: ThemeStyles.addButtonTextStyle),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

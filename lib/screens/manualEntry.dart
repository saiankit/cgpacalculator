import 'package:CgpaCalculator/core/routes.dart';
import 'package:CgpaCalculator/data/hive_api.dart';
import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/providerStates/courseInfo.dart';
import 'package:CgpaCalculator/screens/loadingScreen/loginLoading.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ManualEntry extends StatefulWidget {
  @override
  _ManualEntryState createState() => _ManualEntryState();
}

class _ManualEntryState extends State<ManualEntry> {
  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  String cgpa;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => CourseInfoState(),
          child: Consumer<CourseInfoState>(
            builder: (context, courseInfoState, _) => isLoading
                ? loginLoading()
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Semester until which manual data is to be considered',
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
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
                                          value: Provider.of<CourseInfoState>(
                                                  context)
                                              .defaultSemesterManual,
                                          items: semesterList
                                              .map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (String value) {
                                            Provider.of<CourseInfoState>(
                                                    context,
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
                                  Provider.of<CourseInfoState>(context,
                                          listen: false)
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
                                  Provider.of<CourseInfoState>(context,
                                          listen: false)
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
                          ],
                        ),
                        _keyboardIsVisible() == false
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amberAccent[100],
                                    border: Border.all(color: Colors.amber),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: Text(
                                            'Attention!',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                        Text(
                                          'By clicking here the courses added until ${Provider.of<CourseInfoState>(context).defaultSemesterManual} won\'t be considered for calculation of CGPA and would be deleted if any courses are added until ${Provider.of<CourseInfoState>(context).defaultSemesterManual} and the manual data entered would be considered',
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLoading = true;
                            });
                            String manualCredits = Provider.of<CourseInfoState>(
                                    context,
                                    listen: false)
                                .manualExhaust;

                            String manualCGPA = Provider.of<CourseInfoState>(
                                    context,
                                    listen: false)
                                .manualEntryCG;

                            String manualSem = Provider.of<CourseInfoState>(
                                    context,
                                    listen: false)
                                .defaultSemesterManual;
                            hiveAddData(
                                manualCGPA: manualCGPA,
                                manualCredits: manualCredits,
                                manualSem: manualSem);

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            setState(() {
                              isLoading = false;
                            });
                            navigateToMyApp(context);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Text('Enter Manual Data',
                                  style: ThemeStyles.addButtonTextStyle),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

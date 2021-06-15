import 'package:CgpaCalculator/data/hive_api.dart';
import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:CgpaCalculator/viewModels/courseInfo.dart';
import 'package:CgpaCalculator/views/components/appbar.dart';
import 'package:CgpaCalculator/views/components/calculatorRow.dart';
import 'package:CgpaCalculator/views/components/creditRow.dart';
import 'package:CgpaCalculator/views/components/noItems.dart';
import 'package:CgpaCalculator/views/widgets/addAnewCourseButtonHomeScreen.dart';
import 'package:CgpaCalculator/views/widgets/courseCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addCourse.dart';

String fuid;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fuid = prefs.getString('uid');
    return fuid;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getID(), // future call to read the User ID
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ChangeNotifierProvider(
                    create: (_) => CourseInfoState(),
                    child: Consumer<CourseInfoState>(
                      builder: (context, semState, _) => Container(
                        child: Column(
                          children: <Widget>[
                            Appbar(fuid: fuid, homeScreenContext: context),
                            CalculatorRow(
                                fuid: fuid, homeScreenContext: context),
                            CreditRow(fuid: fuid, homeScreenContext: context),
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                var _semesterCode =
                                    Provider.of<CourseInfoState>(context,
                                            listen: false)
                                        .selectedSemester;
                                int semIndexHome =
                                    hiveGetData('manualSem') == null
                                        ? null
                                        : semesterList
                                            .indexOf(hiveGetData('manualSem'));

                                if (semIndexHome == null) {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.60,
                                      decoration: ThemeStyles
                                          .modalBottomSheetDecoration,
                                      child: AddCourseScreen(
                                          _semesterCode, context),
                                    ),
                                  );
                                } else {
                                  if (semesterList.indexOf(_semesterCode) <=
                                      semIndexHome) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Access Denied',
                                              style:
                                                  ThemeStyles.marqueeTextStyle),
                                          content: Text(
                                              'You cannot access addition of courses in this semester because manual data added by you is being considered for this semester.',
                                              style:
                                                  ThemeStyles.titleTextStyle),
                                        );
                                      },
                                    );
                                  } else {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.60,
                                        decoration: ThemeStyles
                                            .modalBottomSheetDecoration,
                                        child: AddCourseScreen(
                                            _semesterCode, context),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: AddAnewCourseButton(),
                            ),
                            Expanded(
                              child: StreamBuilder(
                                stream: Provider.of<AppDatabase>(context)
                                    .watchCoursesBySemesterCode(
                                        Provider.of<CourseInfoState>(context)
                                            .selectedSemester,
                                        fuid),
                                builder: (context,
                                    AsyncSnapshot<List<Course>> snapshot) {
                                  if (!snapshot.hasData)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  if (snapshot.data.isEmpty) {
                                    return NoItemsOops();
                                  }

                                  return ListView.builder(
                                    itemBuilder: (_, index) {
                                      return CourseCard(
                                        courseCode:
                                            snapshot.data[index].courseCode,
                                        gradeAchieved:
                                            snapshot.data[index].gradeAchieved,
                                        courseID: snapshot.data[index].courseID,
                                        courseTitle:
                                            snapshot.data[index].courseTitle,
                                        courseCredits:
                                            snapshot.data[index].courseCredits,
                                        semesterCode:
                                            Provider.of<CourseInfoState>(
                                                    context)
                                                .selectedSemester,
                                        documentID: snapshot.data[index].id,
                                      );
                                    },
                                    itemCount: snapshot.data.length,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}

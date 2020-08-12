import 'package:CgpaCalculator/components/appbar.dart';
import 'package:CgpaCalculator/components/creditRow.dart';
import 'package:CgpaCalculator/components/noItems.dart';
import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/screens/addCourse.dart';
import 'package:CgpaCalculator/screens/manualEntry.dart';
import 'package:CgpaCalculator/services/semesterState.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:CgpaCalculator/widgets/addAnewCourseButtonHomeScreen.dart';
import 'package:CgpaCalculator/components/calculatorRow.dart';
import 'package:CgpaCalculator/widgets/courseCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // Setting DeviceOrientation to potrait mode ONLY - flutter services plugin required
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return FutureBuilder<String>(
      future: getID(), // future call to read the User ID
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ChangeNotifierProvider(
                      create: (_) => SemesterState(),
                      child: Consumer<SemesterState>(
                        builder: (context, semState, _) => Container(
                          child: Column(
                            children: <Widget>[
                              Appbar(),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.30,
                                      decoration: ThemeStyles
                                          .modalBottomSheetDecoration,
                                      child: ManualEntry(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 10.0, right: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5.0),
                                                  child: Icon(Icons.add_alert),
                                                ),
                                                Text(
                                                    'Add CG to particular semester'),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              CalculatorRow(
                                  fuid: fuid, homeScreenContext: context),
                              CreditRow(fuid: fuid, homeScreenContext: context),
                              GestureDetector(
                                onTap: () {
                                  var _semesterCode =
                                      Provider.of<SemesterState>(context,
                                              listen: false)
                                          .selectedSemester;
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
                                      child: AddCourseScreen(_semesterCode),
                                    ),
                                  );
                                },
                                child: AddAnewCourseButton(),
                              ),
                              Expanded(
                                child: StreamBuilder(
                                  stream: Provider.of<AppDatabase>(context)
                                      .watchCoursesBySemesterCode(
                                          Provider.of<SemesterState>(context)
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
                                          gradeAchieved: snapshot
                                              .data[index].gradeAchieved,
                                          courseID:
                                              snapshot.data[index].courseID,
                                          courseTitle:
                                              snapshot.data[index].courseTitle,
                                          courseCredits: snapshot
                                              .data[index].courseCredits,
                                          semesterCode:
                                              Provider.of<SemesterState>(
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
              ),
            );
        }
      },
    );
  }
}

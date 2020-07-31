import 'package:CgpaCalculator/components/appbar.dart';
import 'package:CgpaCalculator/components/noItems.dart';
import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/screens/addCourse.dart';
import 'package:CgpaCalculator/services/auth.dart';
import 'package:CgpaCalculator/services/semesterState.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
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
    // Setting DeviceOrientation to potrait mode ONLY
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    return FutureBuilder<String>(
      future: getID(), // function where you call your api
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
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ChangeNotifierProvider(
                      create: (_) => SemesterState(),
                      child: Consumer<SemesterState>(
                        builder: (context, semState, _) => Container(
                          child: Column(
                            children: <Widget>[
                              Appbar(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, left: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Text('SGPA',
                                              style: ThemeStyles.gpaTextStyle),
                                        ),
                                        StreamBuilder(
                                          stream: Provider.of<AppDatabase>(
                                                  context)
                                              .watchCoursesBySemesterCode(
                                                  Provider.of<SemesterState>(
                                                          context)
                                                      .selectedSemester,
                                                  fuid),
                                          builder: (context,
                                              AsyncSnapshot<List<Course>>
                                                  snapshot) {
                                            if (!snapshot.hasData)
                                              return Center(
                                                child: Text('0.00',
                                                    style: ThemeStyles
                                                        .gpaNumberTextStyle),
                                              );

                                            int total = 0;
                                            int cred = 0;
                                            String semesterGradePointAverage;
                                            for (var i = 0;
                                                i < snapshot.data.length;
                                                i++) {
                                              total += snapshot
                                                      .data[i].gradeAchieved *
                                                  snapshot
                                                      .data[i].courseCredits;
                                              cred += snapshot
                                                  .data[i].courseCredits;
                                            }
                                            double sg = double.parse(
                                                (total / cred)
                                                    .toStringAsFixed(2));
                                            if (sg.isNaN) {
                                              semesterGradePointAverage =
                                                  '0.00';
                                            } else {
                                              semesterGradePointAverage =
                                                  sg.toString();
                                            }
                                            return Text(
                                                semesterGradePointAverage,
                                                style: ThemeStyles
                                                    .gpaNumberTextStyle);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Text('CGPA',
                                              style: ThemeStyles.gpaTextStyle),
                                        ),
                                        StreamBuilder(
                                          stream:
                                              Provider.of<AppDatabase>(context)
                                                  .watchAllCourses(fuid),
                                          builder: (context,
                                              AsyncSnapshot<List<Course>>
                                                  snapshot) {
                                            if (!snapshot.hasData)
                                              return Center(
                                                child: Text('0.00',
                                                    style: ThemeStyles
                                                        .gpaNumberTextStyle),
                                              );
                                            int total = 0;
                                            int cred = 0;
                                            String cummulativeGradePointAverage;
                                            for (var i = 0;
                                                i < snapshot.data.length;
                                                i++) {
                                              total += snapshot
                                                      .data[i].gradeAchieved *
                                                  snapshot
                                                      .data[i].courseCredits;
                                              cred += snapshot
                                                  .data[i].courseCredits;
                                            }
                                            double cg = double.parse(
                                                (total / cred)
                                                    .toStringAsFixed(2));
                                            if (cg.isNaN) {
                                              cummulativeGradePointAverage =
                                                  '0.00';
                                            } else {
                                              cummulativeGradePointAverage =
                                                  cg.toString();
                                            }
                                            return Text(
                                                cummulativeGradePointAverage,
                                                style: ThemeStyles
                                                    .gpaNumberTextStyle);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  var _semesterCode =
                                      Provider.of<SemesterState>(context,
                                              listen: false)
                                          .selectedSemester;
                                  Provider.of<SemesterState>(context,
                                          listen: false)
                                      .sgpaCalculator(_semesterCode);
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
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 5.0,
                                      bottom: 20.0),
                                  child: Container(
                                    height: 60.0,
                                    decoration: ThemeStyles.addNewCourse,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 30.0, right: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Add a new Course',
                                            style: ThemeStyles.titleTextStyle,
                                          ),
                                          Icon(Icons.add,
                                              color: Colors.grey[600]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
          // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}

import 'package:CgpaCalculator/components/appbar.dart';
import 'package:CgpaCalculator/components/noItemsOops.dart';
import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/screens/addCourse.dart';
import 'package:CgpaCalculator/services/listGenerator.dart';
import 'package:CgpaCalculator/services/semesterState.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:CgpaCalculator/widgets/courseCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Setting DeviceOrientation to potrait mode ONLY
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
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
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text('SGPA',
                                      style: ThemeStyles.gpaTextStyle),
                                ),
                                Text(
                                    Provider.of<SemesterState>(context,
                                            listen: false)
                                        .semesterGradePointAverage,
                                    style: ThemeStyles.gpaNumberTextStyle),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                    Provider.of<SemesterState>(context,
                                            listen: false)
                                        .cummulativeGradePointAverage,
                                    style: ThemeStyles.gpaNumberTextStyle),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var _semesterCode =
                              Provider.of<SemesterState>(context, listen: false)
                                  .selectedSemester;
                          Provider.of<SemesterState>(context, listen: false)
                              .sgpaCalculator(_semesterCode);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.85,
                              decoration:
                                  ThemeStyles.modalBottomSheetDecoration,
                              child: AddCourseScreen(_semesterCode),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 5.0, bottom: 20.0),
                          child: Container(
                            height: 60.0,
                            decoration: ThemeStyles.addNewCourse,
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.0, right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Add a new Course',
                                    style: ThemeStyles.titleTextStyle,
                                  ),
                                  Icon(Icons.add, color: Colors.grey[600]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: Provider.of<AppDatabase>(context)
                              .watchCourseBySemesterCode(
                                  Provider.of<SemesterState>(context)
                                      .selectedSemester),
                          builder:
                              (context, AsyncSnapshot<List<Course>> snapshot) {
                            if (!snapshot.hasData)
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            if (snapshot.data.isEmpty) return NoItemsOops();
                            // print(Provider.of<SemesterState>(context)
                            //     .selectedSemester);
                            return ListView.builder(
                              itemBuilder: (_, index) {
                                return CourseCard(
                                  courseCode: snapshot.data[index].courseCode,
                                  gradeAchieved:
                                      snapshot.data[index].gradeAchieved,
                                  courseID: snapshot.data[index].courseID,
                                  courseTitle: snapshot.data[index].courseTitle,
                                  courseCredits:
                                      snapshot.data[index].courseCredits,
                                  semesterCode:
                                      Provider.of<SemesterState>(context)
                                          .selectedSemester,
                                  documentID: snapshot.data[index].id,
                                );
                              },
                              itemCount: snapshot.data.length,
                            );
                          },
                        ),
                      ),

                      // ListGenerator(
                      //     semesterCode: Provider.of<SemesterState>(context)
                      //         .selectedSemester)
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
}

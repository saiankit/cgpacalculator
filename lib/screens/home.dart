import 'package:CgpaCalculator/components/appbar.dart';
import 'package:CgpaCalculator/components/coursesList.dart';
import 'package:CgpaCalculator/components/testList.dart';
import 'package:CgpaCalculator/screens/addCourse.dart';
import 'package:CgpaCalculator/services/semesterState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                              child: Text(
                                'SGPA',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              Provider.of<SemesterState>(context)
                                  .semesterGradePointAverage,
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '8.33',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCourseScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 5.0, bottom: 20.0),
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Add a new Course',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: null,
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFC4C4C4).withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color(0xFFC4C4C4).withOpacity(0.2),
                        ),
                        height: 60.0,
                      ),
                    ),
                  ),
                  Provider.of<SemesterState>(context).selectedSemester ==
                          '1 - 1'
                      ? CoursesList()
                      : TestList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

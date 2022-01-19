import 'package:cgpacalculator/models/course_model_simplified.dart';
import 'package:cgpacalculator/services/cdc_service.dart';
import 'package:cgpacalculator/services/user_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/disciplinary_elective_service.dart';
import '../../services/humanity_elective_service.dart';
import '../../services/moor_database_service.dart';
import '../../services/open_elective_service.dart';
import '../../utilities/theme_styles.dart';
import '../components/course_card.dart';
import 'analytics_screen.dart';
import 'more_courses.dart';

class ElectiveScreen extends StatefulWidget {
  final int electiveType;

  const ElectiveScreen({
    Key? key,
    required this.electiveType,
  }) : super(key: key);

  @override
  _ElectiveScreenState createState() => _ElectiveScreenState();
}

class _ElectiveScreenState extends State<ElectiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(electiveMap[widget.electiveType]!,
            style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: CustomIcons.arrowBackIOS,
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(Converts.c16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return MoreCoursesScreen(
                            electiveType: widget.electiveType,
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    'View More courses',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            Consumer<UserDetails>(
              builder: (context, courseInfoProvider, _) => StreamBuilder(
                stream: Provider.of<AppDatabase>(context)
                    .watchAllCourses(courseInfoProvider.id),
                builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No Courses'),
                    );
                  }
                  List<CourseSimplified> listOfCourses =
                      (widget.electiveType == 1)
                          ? HumanityElectiveService()
                              .getCompletedHumanityElecitvesList(snapshot)
                          : (widget.electiveType == 2)
                              ? DisciplinaryElectiveService()
                                  .getCompletedDisciplinaryElecitvesList(
                                      snapshot,
                                      courseInfoProvider.primaryDiscipline)
                              : (widget.electiveType == 3)
                                  ? OpenElectiveService()
                                      .getCompletedOpenElecitvesList(snapshot,
                                          courseInfoProvider.primaryDiscipline)
                                  : CDCService().getCompletedCDCCourses(
                                      snapshot,
                                      courseInfoProvider.primaryDiscipline);

                  if (listOfCourses.length == 0)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Converts.c16),
                          child: Column(
                            children: [
                              Text(
                                  'You have not completed any courses in ${electiveMap[widget.electiveType]!}',
                                  style: ThemeStyles.t24TextStyle),
                              SizedBox(height: Converts.c24),
                              Text(
                                'Head Over To View More Courses to get to know ${electiveMap[widget.electiveType]!} that you can probably take up',
                                style: ThemeStyles.t16TextStyle
                                    .copyWith(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return CourseCardUI(
                        course: listOfCourses[index],
                      );
                    },
                    itemCount: listOfCourses.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

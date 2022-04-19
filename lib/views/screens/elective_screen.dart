import 'package:cgpacalculator/models/course_model_simplified.dart';
import 'package:cgpacalculator/services/cdc_service.dart';
import 'package:cgpacalculator/services/user_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../services/disciplinary_elective_service.dart';
import '../../services/elective_mapper_service.dart';
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
        actions: [
          InkWell(
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.push(
                context,
                PageTransition(
                  curve: Curves.easeInOutSine,
                  type: PageTransitionType.fade,
                  child: MoreCoursesScreen(
                    electiveType: widget.electiveType,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: Converts.c12),
                  child: Text(
                    'View More Courses',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(Converts.c16),
        child: Consumer<UserDetails>(
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

              List<CourseSimplified> listOfCourses = ElectiveMapperService()
                  .getCompletedList(
                      courseInfoProvider.primaryDiscipline,
                      widget.electiveType,
                      courseInfoProvider.secondaryDiscipline,
                      snapshot);

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
      ),
    );
  }
}

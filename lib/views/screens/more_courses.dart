import 'package:cgpacalculator/models/course_model_simplified.dart';
import 'package:cgpacalculator/services/user_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/cdc_service.dart';
import '../../services/disciplinary_elective_service.dart';
import '../../services/humanity_elective_service.dart';
import '../../services/moor_database_service.dart';
import '../../services/open_elective_service.dart';
import '../../utilities/theme_styles.dart';
import '../components/course_card.dart';
import 'analytics_screen.dart';

class MoreCoursesScreen extends StatefulWidget {
  final int electiveType;

  const MoreCoursesScreen({
    Key? key,
    required this.electiveType,
  }) : super(key: key);
  @override
  _MoreCoursesScreenState createState() => _MoreCoursesScreenState();
}

class _MoreCoursesScreenState extends State<MoreCoursesScreen> {
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
      body: Consumer<UserDetails>(
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
            List<CourseSimplified> listOfCourses = (widget.electiveType == 1)
                ? HumanityElectiveService()
                    .getMoreHumanityElecitvesList(snapshot)
                : (widget.electiveType == 2)
                    ? DisciplinaryElectiveService()
                        .getMoreDisciplinaryElectivesList(
                            snapshot, courseInfoProvider.primaryDiscipline)
                    : (widget.electiveType == 3)
                        ? OpenElectiveService().getMoreOpenElectivesList(
                            snapshot, courseInfoProvider.primaryDiscipline)
                        : CDCService().getMoreCDCCourses(
                            snapshot, courseInfoProvider.primaryDiscipline);

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Converts.c16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listOfCourses.length,
                itemBuilder: (_, index) {
                  return CourseCardUI(
                    course: listOfCourses[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/services/disciplinaryElectiveService.dart';
import 'package:CgpaCalculator/services/humanityElectiveService.dart';
import 'package:CgpaCalculator/services/openElectiveService.dart';
import 'package:CgpaCalculator/utilities/icons.dart';
import 'package:CgpaCalculator/viewModels/courseInfo.dart';
import 'package:CgpaCalculator/views/components/noItems.dart';
import 'package:CgpaCalculator/views/screens/AnalyticsScreen.dart';
import 'package:CgpaCalculator/views/screens/moreCourses.dart';
import 'package:CgpaCalculator/views/widgets/courseCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ElectiveScreen extends StatefulWidget {
  final int electiveType;
  final String fuid;
  final BuildContext homeScreenContext;

  const ElectiveScreen(
      {Key key, this.electiveType, this.fuid, this.homeScreenContext})
      : super(key: key);

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
        title: Text(electiveMap[widget.electiveType],
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
      body: Container(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MoreCoursesScreen(
                              electiveType: widget.electiveType,
                              fuid: widget.fuid,
                              homeScreenContext: widget.homeScreenContext,
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
            ),
            Consumer<CourseInfoState>(
              builder: (context, courseInfoProvider, _) => StreamBuilder(
                stream: Provider.of<AppDatabase>(widget.homeScreenContext)
                    .watchAllCourses(widget.fuid),
                builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (snapshot.data.isEmpty) {
                    return NoItemsOops();
                  }
                  List<DummyCourseModel> listOfCourses = (widget.electiveType ==
                          1)
                      ? HumanityElectiveService()
                          .getCompletedHumanityElecitvesList(snapshot)
                      : (widget.electiveType == 2)
                          ? DisciplinaryElectiveService()
                              .getCompletedDisciplinaryElecitvesList(snapshot,
                                  courseInfoProvider.selectedPrimaryDiscipline)
                          : OpenElectiveService().getCompletedOpenElecitvesList(
                              snapshot, courseInfoProvider.selectedPrimaryDiscipline);
                  if (listOfCourses == null || listOfCourses.length == 0)
                    return NoItemsOops();
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

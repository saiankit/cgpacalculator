import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/services/disciplinaryElectiveService.dart';
import 'package:CgpaCalculator/services/humanityElectiveService.dart';
import 'package:CgpaCalculator/services/openElectiveService.dart';
import 'package:CgpaCalculator/utilities/icons.dart';
import 'package:CgpaCalculator/viewModels/courseInfo.dart';

import 'package:CgpaCalculator/views/components/noItems.dart';
import 'package:CgpaCalculator/views/screens/AnalyticsScreen.dart';
import 'package:CgpaCalculator/views/widgets/courseCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MoreCoursesScreen extends StatefulWidget {
  final int electiveType;
  final String fuid;
  final BuildContext homeScreenContext;

  const MoreCoursesScreen(
      {Key key, this.electiveType, this.fuid, this.homeScreenContext})
      : super(key: key);
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
      body: Consumer<CourseInfoState>(
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
            List<DummyCourseModel> listOfCourses = (widget.electiveType == 1)
                ? HumanityElectiveService()
                    .getMoreHumanityElecitvesList(snapshot)
                : (widget.electiveType == 2)
                    ? DisciplinaryElectiveService()
                        .getMoreDisciplinaryElectivesList(snapshot,
                            courseInfoProvider.selectedPrimaryDiscipline)
                    : OpenElectiveService().getMoreOpenElectivesList(
                        snapshot, courseInfoProvider.selectedPrimaryDiscipline);

            if (listOfCourses == null) return NoItemsOops();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: listOfCourses.length,
              itemBuilder: (_, index) {
                return CourseCardUI(
                  course: listOfCourses[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

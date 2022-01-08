import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


import '../../data/course_meta_data.dart';
import '../../services/moor_database_service.dart';
import '../../services/user_details_view_model.dart';
import '../../utilities/theme_styles.dart';
import '../components/appbar.dart';
import '../components/course_card.dart';
import '../components/credit_row.dart';
import '../components/grade_point_row.dart';
import 'add_new_course_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Converts.c16),
          child: Column(
            children: [
              Appbar(),
              GradePointUI(),
              CreditRow(),
              Consumer<UserDetails>(
                builder: (context, userDetails, _) => GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    var _semesterCode = userDetails.sem;
                    int? semIndexHome =
                        semesterList.indexOf(userDetails.manualSem);

                    if (semIndexHome == null) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.50,
                          decoration: ThemeStyles.modalBottomSheetDecoration,
                          child: AddCourseScreen(),
                        ),
                      );
                    } else {
                      if (semesterList.indexOf(_semesterCode) <= semIndexHome) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Access Denied',
                                  style: ThemeStyles.t24TextStyle),
                              content: Text(
                                'You cannot access addition of courses in this semester because manual data added by you is being considered for this semester.',
                                style: ThemeStyles.t16TextStyle
                                    .copyWith(color: Colors.grey[600]),
                              ),
                            );
                          },
                        );
                      } else {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.50,
                            decoration: ThemeStyles.modalBottomSheetDecoration,
                            child: AddCourseScreen(),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    height: Converts.c64,
                    decoration: ThemeStyles.addNewCourse,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Converts.c32, right: Converts.c16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Add a new Course',
                            style: ThemeStyles.t16TextStyle
                                .copyWith(color: Colors.grey[600]),
                          ),
                          Icon(Icons.add, color: Colors.grey[600]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Converts.c8),
              Expanded(
                child: Consumer<UserDetails>(
                  builder: (context, userDetails, _) => StreamBuilder(
                    stream: Provider.of<AppDatabase>(context)
                        .watchCoursesBySemesterCode(
                            userDetails.sem, userDetails.id),
                    builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      if (snapshot.data!.isEmpty) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'No courses added yet',
                                style: ThemeStyles.t24TextStyle,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemBuilder: (_, index) {
                          return CourseCard(
                            courseCode: snapshot.data![index].courseCode,
                            gradeAchieved: snapshot.data![index].gradeAchieved,
                            courseID: snapshot.data![index].courseID,
                            courseTitle: snapshot.data![index].courseTitle,
                            courseCredits: snapshot.data![index].courseCredits,
                            semesterCode: userDetails.sem,
                            documentID: snapshot.data![index].id,
                            userID: userDetails.id,
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

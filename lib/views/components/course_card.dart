import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/user_details_view_model.dart';
import '../../utilities/theme_styles.dart';
import '../../services/course_view_model.dart';
import '../screens/course_update_screen.dart';

class CourseCard extends StatefulWidget {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseCredits;
  final int gradeAchieved;
  final int documentID;
  final String semesterCode;
  final String userID;
  CourseCard({
    required this.courseCode,
    required this.courseCredits,
    required this.gradeAchieved,
    required this.courseID,
    required this.courseTitle,
    required this.documentID,
    required this.semesterCode,
    required this.userID,
  });
  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetails>(
      builder: (context, userDetails, _) => GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: ThemeStyles.modalBottomSheetDecoration,
              child: CourseUpdate(
                courseCode: widget.courseCode,
                courseGrade: widget.gradeAchieved,
                courseID: widget.courseID,
                courseTitle: widget.courseTitle,
                courseCredits: widget.courseCredits,
                documentID: widget.documentID,
                semesterCode: widget.semesterCode,
                userID: widget.userID,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Converts.c8),
          child: Container(
            height: Converts.c64,
            decoration: ThemeStyles.courseCardDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: Converts.c64,
                  width: Converts.c64,
                  decoration: ThemeStyles.courseCardCourseInfo,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.courseCode,
                        style: ThemeStyles.t12TextStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      Text(
                        widget.courseID,
                        style: ThemeStyles.t12TextStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: Converts.c8),
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.courseTitle,
                      style: ThemeStyles.t16TextStyle
                          .copyWith(color: Colors.grey[600]),
                    ),
                  ),
                ),
                Container(
                  height: Converts.c64,
                  width: Converts.c64,
                  decoration: ThemeStyles.courseCardGradeInfo,
                  child: Center(
                    child: Text(
                      CourseViewModel.mapToLetterGrades(widget.gradeAchieved),
                      style: ThemeStyles.t20TextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class CourseCardUI extends StatefulWidget {
//   final DummyCourseModel course;

//   const CourseCardUI({Key? key, required this.course}) : super(key: key);

//   @override
//   _CourseCardUIState createState() => _CourseCardUIState();
// }

// class _CourseCardUIState extends State<CourseCardUI> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => CourseInfoState(),
//       child: Consumer<CourseInfoState>(
//         builder: (context, semState, _) => Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
//           child: Container(
//             height: 64.0,
//             decoration: ThemeStyles.courseCardDecoration,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   height: 64.0,
//                   width: 64.0,
//                   decoration: ThemeStyles.courseCardCourseInfo,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         widget.course.courseCode,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       Text(
//                         widget.course.courseID,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: EdgeInsets.only(left: 10.0),
//                     scrollDirection: Axis.horizontal,
//                     child: Text(widget.course.courseTitle,
//                         style: ThemeStyles.titleTextStyle),
//                   ),
//                 ),
//                 Container(
//                   height: 64.0,
//                   width: 64.0,
//                   decoration: ThemeStyles.courseCardGradeInfo,
//                   child: Center(
//                     child: Text(
//                       widget.course.courseCredits,
//                       style: TextStyle(fontSize: 25.0, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

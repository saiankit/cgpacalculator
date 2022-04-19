import 'package:cgpacalculator/services/elective_mapper_service.dart';
import 'package:cgpacalculator/views/screens/elective_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../services/credits_calculator.dart';
import '../../services/moor_database_service.dart';
import '../../services/user_details_view_model.dart';
import '../../utilities/theme_styles.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({
    Key? key,
  }) : super(key: key);
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: CustomIcons.arrowBackIOS,
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<UserDetails>(
        builder: (context, userDetails, _) => userDetails.primaryDiscipline ==
                'None'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Converts.c16),
                    child: Column(
                      children: [
                        Text(
                            'Please Enter Your Primary Discipline to Continue with Analytics Screen',
                            style: ThemeStyles.t24TextStyle),
                        SizedBox(height: Converts.c24),
                        Text(
                          'Head Over To Settings to Enter Your Primary Discipline',
                          style: ThemeStyles.t16TextStyle
                              .copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                      width: Converts.c350,
                      child: Image.asset('assets/cube-dynamic-color.png')),
                ],
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Converts.c8, horizontal: Converts.c24),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: Converts.c12),
                        child: Container(
                          width: double.infinity,
                          height: Converts.c160,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 15, 17, 19)
                                    .withOpacity(0.25),
                                spreadRadius: 0.0,
                                blurRadius: 20.0,
                                offset: Offset(0, 0.0),
                              ),
                              BoxShadow(
                                color: Color(0xff212529).withOpacity(0.06),
                                spreadRadius: 0.0,
                                blurRadius: 2.0,
                                offset: Offset(0, 2.0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(Converts.c8),
                            color: Color(0xff111111),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(Converts.c20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your Total Credits',
                                      style: ThemeStyles.t12TextStyle.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100),
                                    ),
                                    StreamBuilder(
                                      stream: Provider.of<AppDatabase>(context)
                                          .watchAllCourses(userDetails.id),
                                      builder: (context,
                                          AsyncSnapshot<List<Course>>
                                              snapshot) {
                                        if (!snapshot.hasData)
                                          return Center(
                                            child: Text(
                                              ' 81',
                                              style: ThemeStyles.t32TextStyle,
                                            ),
                                          );
                                        String credits = countAllCredits(
                                          snapshot,
                                        );
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline:
                                              TextBaseline.ideographic,
                                          children: [
                                            Text(
                                              ' ' + credits,
                                              style: ThemeStyles.t32TextStyle
                                                  .copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              ' /144',
                                              style: ThemeStyles.t20TextStyle
                                                  .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElectiveCard(electiveType: 1),
                          ElectiveCard(electiveType: 2),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElectiveCard(electiveType: 3),
                          ElectiveCard(electiveType: 4),
                        ],
                      ),
                      userDetails.secondaryDiscipline == 'None'
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElectiveCard(electiveType: 5),
                                ElectiveCard(electiveType: 6),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

Map<int, String> electiveMap = {
  1: 'Humanity Electives',
  2: 'Open Electives',
  3: 'CDC',
  4: 'Disciplinary Electives',
  5: 'CDC',
  6: 'Disciplinary Electives'
};

class ElectiveCard extends StatelessWidget {
  final int electiveType;

  const ElectiveCard({Key? key, required this.electiveType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.easeInOutSine,
            type: PageTransitionType.fade,
            child: ElectiveScreen(
              electiveType: electiveType,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Converts.c12),
        child: Container(
          width: Converts.c168,
          height: Converts.c168,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff212529).withOpacity(0.08),
                spreadRadius: 0.0,
                blurRadius: 10.0,
                offset: Offset(0, 0.0),
              ),
              BoxShadow(
                color: Color(0xff212529).withOpacity(0.05),
                spreadRadius: 0.0,
                blurRadius: 5.0,
                offset: Offset(0, 5.0),
              ),
            ],
            borderRadius: BorderRadius.circular(Converts.c8),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(Converts.c12),
            child: Consumer<UserDetails>(
              builder: (context, userDetails, _) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    electiveMap[this.electiveType]!,
                    style: ThemeStyles.t16TextStyle.copyWith(
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  (this.electiveType == 3 || this.electiveType == 4)
                      ? Text(
                          userDetails.primaryDiscipline,
                          style: ThemeStyles.t16TextStyle.copyWith(
                            fontWeight: FontWeight.w100,
                          ),
                        )
                      : Container(),
                  (this.electiveType == 5 || this.electiveType == 6)
                      ? Text(
                          userDetails.secondaryDiscipline,
                          style: ThemeStyles.t16TextStyle.copyWith(
                            fontWeight: FontWeight.w100,
                          ),
                        )
                      : Container(),
                  StreamBuilder(
                    stream: Provider.of<AppDatabase>(context)
                        .watchAllCourses(userDetails.id),
                    builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                      if (!snapshot.hasData)
                        return Text(
                          '0',
                          style: ThemeStyles.t20TextStyle,
                        );
                      String electiveCredits = ElectiveMapperService()
                          .getCompletedCredits(
                              userDetails.primaryDiscipline,
                              this.electiveType,
                              userDetails.secondaryDiscipline,
                              snapshot);
                      String electiveCourses = ElectiveMapperService()
                          .getCompletedCourses(
                              userDetails.primaryDiscipline,
                              this.electiveType,
                              userDetails.secondaryDiscipline,
                              snapshot);
                      String maxCourses = ElectiveMapperService().getMaxCourses(
                          userDetails.primaryDiscipline,
                          this.electiveType,
                          userDetails.secondaryDiscipline,
                          snapshot);
                      String maxCredits = ElectiveMapperService().getMaxCredits(
                          userDetails.primaryDiscipline,
                          this.electiveType,
                          userDetails.secondaryDiscipline,
                          snapshot);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'COURSES',
                                style: ThemeStyles.t12TextStyle.copyWith(
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    electiveCourses,
                                    style: ThemeStyles.t20TextStyle,
                                  ),
                                  Text(
                                    ' /$maxCourses ',
                                    style: ThemeStyles.t20TextStyle.copyWith(
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CREDITS',
                                style: ThemeStyles.t12TextStyle.copyWith(
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    electiveCredits,
                                    style: ThemeStyles.t20TextStyle,
                                  ),
                                  Text(
                                    ' /$maxCredits ',
                                    style: ThemeStyles.t20TextStyle.copyWith(
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

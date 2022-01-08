import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/credits_calculator.dart';
import '../../services/disciplinary_elective_service.dart';
import '../../services/humanity_elective_service.dart';
import '../../services/moor_database_service.dart';
import '../../services/open_elective_service.dart';
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
        builder: (context, userDetails, _) => userDetails.primarDiscipline ==
                'None'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Converts.c24),
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Converts.c20),
                      child: Container(
                        width: double.infinity,
                        height: Converts.c200,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.70),
                              spreadRadius: 0.0,
                              blurRadius: 24.0,
                              offset: Offset(0, 8.0),
                            )
                          ],
                          borderRadius: BorderRadius.circular(Converts.c8),
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Converts.c8),
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
                                        AsyncSnapshot<List<Course>> snapshot) {
                                      if (!snapshot.hasData)
                                        return Center(
                                          child: Text(
                                            ' 81',
                                            style: ThemeStyles.t32TextStyle,
                                          ),
                                        );
                                      String credits = countAllCredits(
                                          snapshot, userDetails.manualCredits);
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.ideographic,
                                        children: [
                                          Text(
                                            ' ' + credits,
                                            style: ThemeStyles.t32TextStyle
                                                .copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            ' /145',
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
                              Container(
                                height: Converts.c104,
                                width: Converts.c104,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3.0,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StreamBuilder(
                                      stream: Provider.of<AppDatabase>(context)
                                          .watchAllCourses(userDetails.id),
                                      builder: (context,
                                          AsyncSnapshot<List<Course>>
                                              snapshot) {
                                        if (!snapshot.hasData)
                                          return Center(
                                            child: Text(
                                              ' 0' + '%',
                                              style: ThemeStyles.t32TextStyle
                                                  .copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          );

                                        String credits = countAllCredits(
                                            snapshot, userDetails.id);
                                        String percentage =
                                            ((int.parse(credits) / 145) * 100)
                                                .toStringAsFixed(2);
                                        return Text(
                                          ' ' + percentage + '%',
                                          style: ThemeStyles.t20TextStyle,
                                        );
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 5),
                                        Text(
                                          'done',
                                          style:
                                              ThemeStyles.t12TextStyle.copyWith(
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //HEL
                    ElectivesCard(electiveType: 1),
                    ElectivesCard(electiveType: 2),
                    ElectivesCard(electiveType: 3),
                  ],
                ),
              ),
      ),
    );
  }
}

Map<int, String> electiveMap = {
  1: 'Humanity Electives',
  2: 'Disciplinary Electives',
  3: 'Open Electives'
};

class ElectivesCard extends StatefulWidget {
  final int electiveType;

  const ElectivesCard({
    Key? key,
    required this.electiveType,
  }) : super(key: key);
  @override
  _ElectivesCardState createState() => _ElectivesCardState();
}

class _ElectivesCardState extends State<ElectivesCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return ElectiveScreen(
        //         electiveType: widget.electiveType,
        //         fuid: widget.fuid,
        //         homeScreenContext: widget.homeScreenContext,
        //       );
        //     },
        //   ),
        // );
      },
      child: Padding(
        padding: EdgeInsets.all(Converts.c20),
        child: Container(
          width: double.infinity,
          height: Converts.c120,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.70),
                spreadRadius: 0.0,
                blurRadius: 24.0,
                offset: Offset(0, 8.0),
              )
            ],
            borderRadius: BorderRadius.circular(Converts.c8),
            color: Colors.black,
          ),
          child: Padding(
            padding: EdgeInsets.all(Converts.c8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  electiveMap[widget.electiveType]!,
                  style: ThemeStyles.t12TextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Consumer<UserDetails>(
                  builder: (context, userDetails, _) => StreamBuilder(
                    stream: Provider.of<AppDatabase>(context)
                        .watchAllCourses(userDetails.id),
                    builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                      if (!snapshot.hasData)
                        return Text(
                          '0',
                          style: ThemeStyles.t32TextStyle,
                        );
                      String electiveCredits = (widget.electiveType == 1)
                          ? HumanityElectiveService().countCredits(snapshot)
                          : (widget.electiveType == 2)
                              ? DisciplinaryElectiveService().countCredits(
                                  snapshot, userDetails.primarDiscipline)
                              : OpenElectiveService().countCredits(
                                  snapshot, userDetails.primarDiscipline);
                      String electiveCourses = (widget.electiveType == 1)
                          ? HumanityElectiveService().countCourses(snapshot)
                          : (widget.electiveType == 2)
                              ? DisciplinaryElectiveService().countCourses(
                                  snapshot, userDetails.primarDiscipline)
                              : OpenElectiveService().countCredits(
                                  snapshot, userDetails.primarDiscipline);
                      String maxCourses = (widget.electiveType == 1)
                          ? '3'
                          : (widget.electiveType == 2)
                              ? '5'
                              : '5';
                      String maxCredits = (widget.electiveType == 1)
                          ? '9'
                          : (widget.electiveType == 2)
                              ? '15'
                              : '15';
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              Text(
                                // ' ' + '21',
                                ' ' + electiveCourses,
                                style: ThemeStyles.t32TextStyle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                ' /$maxCourses ',
                                style: ThemeStyles.t20TextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              Text(
                                'credits',
                                style: ThemeStyles.t16TextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              Text(
                                ' ' + electiveCredits,
                                // ' ' + '21',
                                style: ThemeStyles.t32TextStyle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                ' /$maxCredits ',
                                style: ThemeStyles.t20TextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              Text(
                                'credits',
                                style: ThemeStyles.t16TextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
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

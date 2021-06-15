import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/services/creditsCalculator.dart';
import 'package:CgpaCalculator/services/disciplinaryElectiveService.dart';
import 'package:CgpaCalculator/services/humanityElectiveService.dart';
import 'package:CgpaCalculator/services/openElectiveService.dart';
import 'package:CgpaCalculator/utilities/icons.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'ElectiveScreen.dart';

class AnalyticsScreen extends StatefulWidget {
  final String fuid;
  final BuildContext homeScreenContext;

  const AnalyticsScreen({Key key, this.homeScreenContext, this.fuid})
      : super(key: key);
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    boxShadow: ThemeStyles.shadowStyle,
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Total Credits',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                            StreamBuilder(
                              stream: Provider.of<AppDatabase>(
                                      widget.homeScreenContext)
                                  .watchAllCourses(widget.fuid),
                              builder: (context,
                                  AsyncSnapshot<List<Course>> snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                    child: Text(
                                      ' 81',
                                      style: TextStyle(
                                        fontSize: 38.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                String credits = countAllCredits(snapshot);
                                return Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.ideographic,
                                  children: [
                                    Text(
                                      ' ' + credits,
                                      style: TextStyle(
                                        fontSize: 38.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' /145',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        Container(
                          height: 100,
                          width: 100,
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
                                stream: Provider.of<AppDatabase>(
                                        widget.homeScreenContext)
                                    .watchAllCourses(widget.fuid),
                                builder: (context,
                                    AsyncSnapshot<List<Course>> snapshot) {
                                  if (!snapshot.hasData)
                                    return Center(
                                      child: Text(
                                        ' 0' + '%',
                                        style: TextStyle(
                                          fontSize: 38.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );

                                  String credits = countAllCredits(snapshot);
                                  String percentage =
                                      ((int.parse(credits) / 145) * 100)
                                          .toStringAsFixed(2);
                                  return Text(
                                    ' ' + percentage + '%',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 5),
                                  Text(
                                    'done',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
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
              ElectivesCard(
                  fuid: widget.fuid,
                  homeScreenContext: widget.homeScreenContext,
                  electiveType: 1),
              ElectivesCard(
                  fuid: widget.fuid,
                  homeScreenContext: widget.homeScreenContext,
                  electiveType: 2),
              ElectivesCard(
                  fuid: widget.fuid,
                  homeScreenContext: widget.homeScreenContext,
                  electiveType: 3),
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
  final String fuid;
  final BuildContext homeScreenContext;
  final int electiveType;

  const ElectivesCard(
      {Key key, this.fuid, this.homeScreenContext, this.electiveType})
      : super(key: key);
  @override
  _ElectivesCardState createState() => _ElectivesCardState();
}

class _ElectivesCardState extends State<ElectivesCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ElectiveScreen(
                electiveType: widget.electiveType,
                fuid: widget.fuid,
                homeScreenContext: widget.homeScreenContext,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Container(
          width: double.infinity,
          height: 100.0,
          decoration: BoxDecoration(
            boxShadow: ThemeStyles.shadowStyle,
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  electiveMap[widget.electiveType],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                StreamBuilder(
                  stream: Provider.of<AppDatabase>(widget.homeScreenContext)
                      .watchAllCourses(widget.fuid),
                  builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                    if (!snapshot.hasData)
                      return Text(
                        '0',
                        style: TextStyle(
                          fontSize: 38.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    String electiveCredits = (widget.electiveType == 1)
                        ? HumanityElectiveService().countCredits(snapshot)
                        : (widget.electiveType == 2)
                            ? DisciplinaryElectiveService()
                                .countCredits(snapshot, 'AA')
                            : OpenElectiveService().countCredits(snapshot, 'AA');
                    String electiveCourses = (widget.electiveType == 1)
                        ? HumanityElectiveService().countCourses(snapshot)
                        : (widget.electiveType == 2)
                            ? DisciplinaryElectiveService()
                                .countCourses(snapshot, 'AA')
                            : OpenElectiveService().countCredits(snapshot, 'AA');
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
                              ' ' + electiveCourses,
                              style: TextStyle(
                                fontSize: 38.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' /$maxCourses courses',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                              style: TextStyle(
                                fontSize: 38.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' /$maxCredits credits',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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
    );
  }
}

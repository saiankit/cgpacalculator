import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/services/creditsCalculator.dart';
import 'package:CgpaCalculator/services/departmentCreditsCalculator.dart';
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
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 40.0),
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1.0,
                      blurRadius: 10.0,
                      offset: Offset(3.0, 3.0),
                    )
                  ],
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
                              return Text(
                                ' ' + credits,
                                style: TextStyle(
                                  fontSize: 38.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
            Row(
              children: [
                Col(
                  title: 'HEL',
                  credits: '6',
                  creditsMax: '9',
                  homeScreenContext: widget.homeScreenContext,
                  fuid: widget.fuid,
                ),
                Col(
                  title: 'DEL',
                  credits: '1',
                  creditsMax: '15',
                  homeScreenContext: widget.homeScreenContext,
                  fuid: widget.fuid,
                ),
              ],
            ),
            Row(
              children: [
                Col(
                  title: 'OEL',
                  credits: '6',
                  creditsMax: '15',
                  homeScreenContext: widget.homeScreenContext,
                  fuid: widget.fuid,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Col extends StatelessWidget {
  final String credits;
  final String creditsMax;
  final String title;
  final String fuid;
  final BuildContext homeScreenContext;

  const Col(
      {Key key,
      this.credits,
      this.creditsMax,
      this.title,
      this.fuid,
      this.homeScreenContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ElectiveScreen(
                title: title == 'HEL'
                    ? 'Humanities'
                    : (title == 'DEL' ? 'Disciplinary' : 'Open'),
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Container(
          height: 200.0,
          width: 140.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 1.0,
                blurRadius: 10.0,
                offset: Offset(3.0, 3.0),
              )
            ],
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                      ),
                    ),
                    Text(
                      title == 'HEL'
                          ? 'Humanities'
                          : (title == 'DEL' ? 'Disciplinary' : 'Open'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    StreamBuilder(
                      stream: Provider.of<AppDatabase>(homeScreenContext)
                          .watchAllCourses(fuid),
                      builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: Text(
                              ' 0',
                              style: TextStyle(
                                fontSize: 60.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        String credits;

                        if (title == "HEL") {

                          credits = countHelCredits(snapshot);
                        } else if (title == "DEL") {
                          credits = countDELCredits(snapshot, 'AA');
                        } else {
                          credits = countOELCredits(snapshot, 'AA');
                        }
                        return Text(
                          credits,
                          style: TextStyle(
                            fontSize: 60.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'out of',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          creditsMax,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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

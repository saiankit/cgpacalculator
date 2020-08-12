import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/services/courseInfo.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ManualEntry extends StatefulWidget {
  @override
  _ManualEntryState createState() => _ManualEntryState();
}

class _ManualEntryState extends State<ManualEntry> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseInfoState(),
      child: Consumer<CourseInfoState>(
        builder: (context, courseInfoState, _) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Semester until which '),
              Container(
                height: 60.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                      underline: Container(),
                      value: Provider.of<CourseInfoState>(context)
                          .defaultSemesterManual,
                      items: semesterList.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (String value) {
                        Provider.of<CourseInfoState>(context, listen: false)
                            .changeManualSemester(value);
                      },
                    ),
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

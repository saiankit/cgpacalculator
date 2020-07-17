import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/models/courseDetails.dart';
import 'package:CgpaCalculator/services/semesterState.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appbar extends StatefulWidget {
  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                scaffoldkey.currentState.openEndDrawer();
                print('Hi');
              },
            ),
            Container(
              height: 45,
              width: 110,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                  underline: Container(),
                  value: Provider.of<SemesterState>(context).selectedSemester,
                  items: semesterList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    Provider.of<SemesterState>(context, listen: false)
                        .changeToSemester(value);
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('CGPA', style: ThemeStyles.gpaTextStyle),
        )
      ],
    );
  }
}

import 'package:CgpaCalculator/models/courseDetails.dart';
import 'package:CgpaCalculator/services/semesterState.dart';
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
              onPressed: null,
            ),
            Container(
              height: 40,
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
                    fontFamily: 'Poppins',
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
          child: Text(
            'CGPA',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
            ),
          ),
        )
      ],
    );
  }
}

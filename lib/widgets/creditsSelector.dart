import 'package:CgpaCalculator/providerStates/courseInfo.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreditSelector extends StatefulWidget {
  int chosenCredits;
  CreditSelector(this.chosenCredits);
  @override
  _CreditSelectorState createState() => _CreditSelectorState();
}

class _CreditSelectorState extends State<CreditSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Credits', style: ThemeStyles.marqueeTextStyle),
        SizedBox(height: 10.0),
        Container(
          height: 60.0,
          width: 80.0,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: DropdownButton<int>(
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
                underline: Container(),
                value: widget.chosenCredits,
                items: [1, 2, 3, 4, 5].map<DropdownMenuItem<int>>(
                  (int value) {
                    return DropdownMenuItem(
                      value: value.toInt(),
                      child: Text(value.toString()),
                    );
                  },
                ).toList(),
                onChanged: (int value) {
                  setState(
                    () {
                      widget.chosenCredits = value;
                    },
                  );
                  Provider.of<CourseInfoState>(context, listen: false)
                      .changeCredits(value);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

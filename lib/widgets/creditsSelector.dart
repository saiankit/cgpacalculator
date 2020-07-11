import 'package:CgpaCalculator/models/courseDetails.dart';
import 'package:flutter/material.dart';

class CreditSelector extends StatefulWidget {
  @override
  _CreditSelectorState createState() => _CreditSelectorState();
}

class _CreditSelectorState extends State<CreditSelector> {
  String _chosenCredits = '1';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Credits',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 20),
          Container(
            height: 60.0,
            width: 65.0,
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
                  value: _chosenCredits,
                  items: credits.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      _chosenCredits = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

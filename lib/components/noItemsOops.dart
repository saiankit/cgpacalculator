import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';

class NoItemsOops extends StatefulWidget {
  @override
  _NoItemsOopsState createState() => _NoItemsOopsState();
}

class _NoItemsOopsState extends State<NoItemsOops> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'Oops!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'No courses added yet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/oops.jpeg'),
            )),
          )
        ],
      ),
    );
  }
}

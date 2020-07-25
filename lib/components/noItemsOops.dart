import 'package:flutter/material.dart';

class NoItemsOops extends StatefulWidget {
  @override
  _NoItemsOopsState createState() => _NoItemsOopsState();
}

class _NoItemsOopsState extends State<NoItemsOops> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'No courses added yet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

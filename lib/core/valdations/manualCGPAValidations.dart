import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void flushCGPAExceed(BuildContext context) {
  Flushbar(
    title: 'Inavlid CGPA',
    message: 'Please enter valid number of CGPA',
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.blue.shade300,
    ),
    leftBarIndicatorColor: Colors.blue.shade300,
    duration: Duration(seconds: 5),
  )..show(context);
}

void flushCGPANaN(BuildContext context) {
  Flushbar(
    title: 'Inavlid CGPA',
    message: 'Please enter valid CGPA rounded to two decimal points',
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.blue.shade300,
    ),
    leftBarIndicatorColor: Colors.blue.shade300,
    duration: Duration(seconds: 5),
  )..show(context);
}

void flushCGPAGreaterThanTen(BuildContext context) {
  Flushbar(
    title: 'Inavlid CGPA',
    message:
        'Please enter valid CGPA which is less than 10 points rounded to two decimal points',
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.blue.shade300,
    ),
    leftBarIndicatorColor: Colors.blue.shade300,
    duration: Duration(seconds: 5),
  )..show(context);
}

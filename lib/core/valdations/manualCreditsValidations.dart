import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void flushCreditsExceed(BuildContext context) {
  Flushbar(
    title: 'Inavlid Credits',
    message: 'Please enter valid number of credits',
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.blue.shade300,
    ),
    leftBarIndicatorColor: Colors.blue.shade300,
    duration: Duration(seconds: 5),
  )..show(context);
}

void flushCreditsNaN(BuildContext context) {
  Flushbar(
    title: 'Inavlid ssCredits',
    message: 'Please enter valid credits which are only integers',
    icon: Icon(
      Icons.info_outline,
      size: 28,
      color: Colors.blue.shade300,
    ),
    leftBarIndicatorColor: Colors.blue.shade300,
    duration: Duration(seconds: 5),
  )..show(context);
}

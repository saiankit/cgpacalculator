import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loginLoading() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Please Wait...', style: ThemeStyles.gpaTextStyle),
        SpinKitPouringHourglass(color: Colors.black),
      ],
    );

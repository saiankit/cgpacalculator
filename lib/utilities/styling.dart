import 'package:CgpaCalculator/utilities/sizeConfig.dart';
import 'package:flutter/material.dart';


class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Color(0xFF091117);
  static const Color textBlackColor = Color(0xff030f16);
  static const Color textWhiteColor = Colors.white;
  static const Color textGreyColor = Color(0xffa4aaa5);
  static const Color greenColor = Color(0xffdee7d3);
  static const Color lightGreenColor = Color(0xffc1e10d);
  static const Color greyDropdown = Color(0xff111e24);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.appBackgroundColor,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline1: _headline1,
    headline2: _headline2,
    headline3: _headline3,
    headline4: _headline4,
    headline5: _headline5,
    headline6: _headline6,
    subtitle1: _subtitle1,
    subtitle2: _subtitle2,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
  );

  static final TextStyle _headline1 = TextStyle(
    color: textWhiteColor,
    fontSize: 4 * SizeConfig.textMultiplier,
    fontFamily: 'Helvetica',
    letterSpacing: 1.5,
  );
  static final TextStyle _headline2 = TextStyle(
    color: textBlackColor,
    fontSize: 2.3 * SizeConfig.textMultiplier,
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _headline3 = TextStyle(
    color: textBlackColor,
    fontSize: 2 * SizeConfig.textMultiplier,
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _headline4 = TextStyle(
    color: textBlackColor,
    fontSize: 1.8 * SizeConfig.textMultiplier,
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _headline5 = TextStyle(
    color: textWhiteColor,
    fontSize: 1.8 * SizeConfig.textMultiplier,
    fontFamily: 'Helvetica',
  );

  static final TextStyle _headline6 = TextStyle(
    color: textBlackColor,
    fontSize: 1.8 * SizeConfig.textMultiplier,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  static final TextStyle _subtitle1 = TextStyle(
    color: textGreyColor,
    fontSize: 1.5 * SizeConfig.textMultiplier,
    fontFamily: 'Roboto',
    letterSpacing: 1.5,
  );
  static final TextStyle _subtitle2 = TextStyle(
    color: Colors.grey[700],
    fontSize: 1.5 * SizeConfig.textMultiplier,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  static final TextStyle _bodyText1 = TextStyle(
    fontSize: 4 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica',
  );
  static final TextStyle _bodyText2 = TextStyle(
    fontSize: 1.5 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica',
  );

  static final EdgeInsetsGeometry screenPadding = EdgeInsets.symmetric(
      horizontal: 2.5 * SizeConfig.heightMultiplier,
      vertical: 2.5 * SizeConfig.widthMultiplier);

  static final BorderRadius borderRadius = BorderRadius.all(
    Radius.circular(4 * SizeConfig.heightMultiplier),
  );

  static final BorderRadius borderRadius2 = BorderRadius.all(
    Radius.circular(1.5 * SizeConfig.heightMultiplier),
  );
}

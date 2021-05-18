import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget loginOnBoardingText() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'C A L C U L A T E',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    '&',
                    style: TextStyle(
                      fontSize: 100.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'J O U R N A L I S E',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );

Widget loginButton() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              blurRadius: 8.0,
              spreadRadius: 0.5,
              offset: Offset(
                2.0,
                10.0,
              ),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/google-logo.svg',
                  height: 28.0,
                  width: 28.0,
                  color: Colors.white,
                ),
                Text(
                  'L  O  G  I  N',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget centerContainerLogin() => Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.grey[200].withOpacity(0.5),
            ),
            child: Center(
              child: Text(
                'CGPA',
                style: TextStyle(
                  fontSize: 100.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[850],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cummulative   Grade   Point   Average',
                style: ThemeStyles.titleTextStyle),
          ],
        ),
      ],
    );

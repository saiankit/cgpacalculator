import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButton extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 62.0,
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
    );
  }
}

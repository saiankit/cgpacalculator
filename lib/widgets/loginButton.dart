import 'package:CgpaCalculator/screens/home.dart';
import 'package:CgpaCalculator/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        authService.signInWithGoogle().whenComplete(
          () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('uid', authService.id);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          },
        );
      },
      child: Container(
        width: 250.0,
        height: 62.0,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              blurRadius: 8.0, // has the effect of softening the shadow
              spreadRadius: 0.5, // has the effect of extending the shadow
              offset: Offset(
                2.0, // horizontal, move right 10
                10.0, // vertical, move down 10
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
      ),
    );
  }
}

import 'package:CgpaCalculator/widgets/loginButton.dart';
import 'package:CgpaCalculator/widgets/loginText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: LoginText(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 55.0),
            child: Container(
              height: 150.0,
              width: 350.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.grey[200].withOpacity(0.5),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'CGPA',
                        style: TextStyle(
                          fontSize: 100.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[850],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: LoginButton(),
          ),
        ],
      ),
    );
  }
}

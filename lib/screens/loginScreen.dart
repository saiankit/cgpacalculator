import 'package:CgpaCalculator/screens/homeScreen.dart';
import 'package:CgpaCalculator/services/auth.dart';
import 'package:CgpaCalculator/utilities/themeStyles.dart';
import 'package:CgpaCalculator/widgets/loginButton.dart';
import 'package:CgpaCalculator/widgets/loginText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please Wait...', style: ThemeStyles.gpaTextStyle),
                SpinKitPouringHourglass(color: Colors.black),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LoginText(),
                Column(
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
                ),
                FlatButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (prefs.getString('uid') == null) {
                      authService.signInWithGoogle().whenComplete(
                        () async {
                          prefs.setString('uid', authService.id).then(
                            (value) {
                              if (prefs.getString('uid') != null) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomeScreen();
                                    },
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    }
                  },
                  child: LoginButton(),
                ),
              ],
            ),
    );
  }
}

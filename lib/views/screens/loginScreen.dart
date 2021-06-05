import 'package:CgpaCalculator/core/routes.dart';
import 'package:CgpaCalculator/services/auth.dart';
import 'package:CgpaCalculator/views/widgets/loginScreenUI.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginLoading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? loginLoading()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                loginOnBoardingText(),
                centerContainerLogin(),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    }); // Setting the state of the screen to load when we actually await for the response from the Shared Preferences
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    // String userIDSharedPreferences = prefs.getString(
                    //     'uid'); // Since we are in the login screen the 'uid' is null
                    //Re-asserting the 'uid'
                    // if (userIDSharedPreferences == null) {
                    authService.signInWithGoogle().whenComplete(
                      () {
                        prefs.setString('uid', authService.id).then(
                          (_) {
                            Navigator.of(context).pop();
                            // if (prefs.getString('uid') != null) {
                            setState(() {
                              isLoading = false;
                            });
                            //Popping the Login Screen out of the Stack
                            // Pushing in the HomeScreen into the stack
                            navigateToHomeScreen(context);
                            // }
                          },
                        );
                      },
                    );
                  },
                  // },
                  child: loginButton(),
                ),
              ],
            ),
    );
  }
}

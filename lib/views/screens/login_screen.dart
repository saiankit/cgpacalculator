import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/authentication_service.dart';
import '../../utilities/theme_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(Converts.c24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text('Journaling & Analysing',
                      style: ThemeStyles.t24TextStyle),
                  Text('Courses & CGPA', style: ThemeStyles.t24TextStyle),
                  Text('Made Easy', style: ThemeStyles.t24TextStyle),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Consumer<GoogleSignInProvider>(
                    builder: (context, provider, child) => GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        provider.googleLogIn();
                      },
                      child: LoginButton(),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Designed and Developed by Sai Ankit'),
                    ],
                  ),
                  SizedBox(height: Converts.c24),
                ],
              ),
            ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Converts.c16),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.25),
            blurRadius: 20.0,
            spreadRadius: 0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      width: double.infinity,
      child: Center(
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}

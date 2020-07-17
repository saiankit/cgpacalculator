import 'package:CgpaCalculator/screens/drawer.dart';
import 'package:CgpaCalculator/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldkey,
        drawer: DrawerScreen(),
        backgroundColor: Colors.white,
        body: LoginPage(),
      ),
    );
  }
}

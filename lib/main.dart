import 'package:CgpaCalculator/screens/drawer.dart';
import 'package:CgpaCalculator/screens/home.dart';
import 'package:CgpaCalculator/screens/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: DrawerScreen(),
        backgroundColor: Colors.white,
        body: HomeScreen(),
      ),
    );
  }
}

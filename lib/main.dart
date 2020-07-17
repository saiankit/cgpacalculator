import 'package:CgpaCalculator/screens/drawer.dart';
import 'package:CgpaCalculator/screens/home.dart';
import 'package:CgpaCalculator/screens/login.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

String uid;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  uid = prefs.getString('uid');
  print("UID:" + uid.toString());
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Colors.black,
      accentColor: Colors.black,
    ),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      drawer: DrawerScreen(),
      backgroundColor: Colors.white,
      body: uid != null ? HomeScreen() : LoginPage(),
    ),
  ));
}

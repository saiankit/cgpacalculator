import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/screens/homeScreen.dart';
import 'package:CgpaCalculator/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userIDSharedPreferences;
String manualCredits;
Future<void> main() async {
  // Using Shared Preferences to persist the logged in user into the device
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  userIDSharedPreferences = prefs.getString('uid');
  // ::Debug:: -- UID of logged-in User
  // print("UID:" + userIDSharedPreferences.toString());
  runApp(MyApp(userIDSharedPreferences));
}

class MyApp extends StatefulWidget {
  final String userIDSharedPreferences;
  MyApp(this.userIDSharedPreferences);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    if (widget.userIDSharedPreferences != null) {
      return Provider<AppDatabase>(
        create: (context) => AppDatabase(),
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.black,
            accentColor: Colors.black,
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            body: HomeScreen(),
          ),
        ),
        dispose: (context, db) => db.close(),
      );
    } else {
      return Provider<AppDatabase>(
        create: (context) => AppDatabase(),
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.black,
            accentColor: Colors.black,
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            body: LoginPage(),
          ),
        ),
        dispose: (context, db) => db.close(),
      );
    }
  }
}

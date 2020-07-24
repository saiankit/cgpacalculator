import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/screens/homeScreen.dart';
import 'package:CgpaCalculator/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String uid;
AppDatabase database;
Future<void> main() async {
  // Using Shared Preferences to persist the logged in user into the device
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  uid = prefs.getString('uid');
  // ::Debug:: -- UID of logged-in User
  print("UID:" + uid.toString());
  runApp(MyApp(uid));
}

class MyApp extends StatefulWidget {
  final String uid;
  MyApp(this.uid);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
          // UID of user stored in shared preferences
          // UID == null -- Connect to LoginPage
          // UID != null -- Connect to HomePage by persisting the user
          body: widget.uid != null ? HomeScreen() : LoginPage(),
        ),
      ),
      dispose: (context, db) => db.close(),
    );
  }
}

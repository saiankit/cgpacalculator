import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/localData/otherCourseData.dart';
import 'package:CgpaCalculator/utilities/sizeConfig.dart';
import 'package:CgpaCalculator/viewModels/courseInfo.dart';
import 'package:CgpaCalculator/views/screens/homeScreen.dart';
import 'package:CgpaCalculator/views/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

String userIDSharedPreferences;
String manualCredits;
String semesterSharedPreferences;

SharedPreferences syncPrefs;
Future<void> main() async {
  // Using Shared Preferences to persist the logged in user into the device
  WidgetsFlutterBinding.ensureInitialized();
  syncPrefs = await SharedPreferences.getInstance();
  userIDSharedPreferences = syncPrefs.getString('uid');
  semesterSharedPreferences = syncPrefs.getString('sem') == null
      ? semesterList[0]
      : syncPrefs.getString('sem');
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
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
    // Setting DeviceOrientation to potrait mode ONLY - flutter services plugin required
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CourseInfoState()),
          ],
          child: Provider<AppDatabase>(
            create: (context) => AppDatabase(),
            child: MaterialApp(
              color: Colors.white,
              theme: ThemeData(
                fontFamily: 'Poppins',
                primaryColor: Colors.black,
                accentColor: Colors.black,
              ),
              debugShowCheckedModeBanner: false,
              home: FutureBuilder(
                future: Hive.openBox('manualData'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(snapshot.error.toString()),
                        ),
                      );
                    } else {
                      return Scaffold(
                        backgroundColor: Colors.white,
                        body: widget.userIDSharedPreferences != null
                            ? HomeScreen()
                            : LoginPage(),
                      );
                    }
                  } else {
                    return Scaffold();
                  }
                },
              ),
            ),
            dispose: (context, db) => db.close(),
          ),
        );
      },
    );
  }
}

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'services/authentication_service.dart';
import 'services/moor_database_service.dart';
import 'services/user_details_view_model.dart';
import 'utilities/screen_config.dart';
import 'views/authentication_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetails()),
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ],
      child: Provider<AppDatabase>(
        create: (context) => AppDatabase(),
        child: MyApp(),
        dispose: (context, db) => db.close(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserDetails>(context, listen: false).onStartUp();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return MaterialApp(
          color: Colors.white,
          theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.black,
          ),
          debugShowCheckedModeBanner: false,
          home: AuthenticationWrapper(),
        );
      },
    );
  }
}

import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/screens/homeScreen.dart';
import 'package:CgpaCalculator/screens/manualEntry.dart';
import 'package:flutter/material.dart';

void navigateToManualEntryScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return ManualEntry();
      },
    ),
  );
}

void navigateToMyApp(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return MyApp(syncPrefs.getString('uid'));
      },
    ),
  );
}

void navigateToHomeScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return HomeScreen();
      },
    ),
  );
}

import 'package:CgpaCalculator/main.dart';
import 'package:CgpaCalculator/screens/AnalyticsScreen.dart';
import 'package:CgpaCalculator/screens/homeScreen.dart';
import 'package:CgpaCalculator/screens/manualEntry.dart';
import 'package:CgpaCalculator/screens/settingsScreen.dart';
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

void navigateToSettingsScreen(BuildContext context, BuildContext homeScreenContext, String fuid) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return SettingsScreen(homeScreenContext: homeScreenContext, fuid: fuid);
      },
    ),
  );
}

void navigateToAnalyticsScreen(
    BuildContext context, BuildContext homeScreenContext, String fuid) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return AnalyticsScreen(
            homeScreenContext: homeScreenContext, fuid: fuid);
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

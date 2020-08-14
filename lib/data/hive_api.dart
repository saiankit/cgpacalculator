import 'package:hive/hive.dart';

void hiveAddData({
  String manualCGPA,
  String manualCredits,
  String manualSem,
}) {
  Hive.box('manualData').put('manualCGPA', manualCGPA);
  Hive.box('manualData').put('manualCredits', manualCredits);
  Hive.box('manualData').put('manualSem', manualSem);
}

void hiveDeleteData() {
  Hive.box('manualData').delete('manualCGPA');
  Hive.box('manualData').delete('manualCredits');
  Hive.box('manualData').delete('manualSem');
}

String hiveGetData(String query) {
  return Hive.box('manualData').get(query);
}

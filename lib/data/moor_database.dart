import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get courseCode => text()();
  TextColumn get courseID => text()();
  TextColumn get courseTitle => text()();
  TextColumn get semesterCode => text()();
  IntColumn get courseCredits => integer()();
  IntColumn get gradeAchieved => integer()();
}

@UseMoor(tables: [Courses])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));
  int get schemaVersion => 1;
}

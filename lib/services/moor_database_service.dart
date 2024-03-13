import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
part 'moor_database_service.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, "db.sqlite"));
    return DatabaseConnection(NativeDatabase.createInBackground(
      file,
      logStatements: true,
    ));
  });
}

class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get courseCode => text()();
  TextColumn get courseID => text()();
  TextColumn get courseTitle => text()();
  TextColumn get semesterCode => text()();
  IntColumn get courseCredits => integer()();
  IntColumn get gradeAchieved => integer()();
  TextColumn get userID => text()();
}

@DriftDatabase(tables: [Courses])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Course>> watchAllCourses(String userID) {
    // return (select(courses)).watch();
    return (select(courses)..where((course) => course.userID.equals(userID)))
        .watch();
  }

  Future insertCourse(Course course) => into(courses).insert(course);
  Future updateCourse(Course course) => update(courses).replace(course);

  Future deleteCourse(Course course) => delete(courses).delete(course);

  Stream<List<Course>> watchCoursesBySemesterCode(
      String semCode, String userID) {
    return (select(courses)
          ..where((course) => course.userID.equals(userID))
          ..where((course) => course.semesterCode.equals(semCode)))
        .watch();
  }

  Future<List<Course>> getCoursesBySemesterCode(String semCode) {
    return (select(courses)
          ..where((course) => course.semesterCode.equals(semCode)))
        .get();
  }
}

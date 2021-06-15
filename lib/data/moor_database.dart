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
  TextColumn get userID => text()();
}

@UseMoor(tables: [Courses])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
              path:
                  "db.sqlite"), //For Log statements add this after the path in this sentence[, logStatements: true]
        );

  @override
  int get schemaVersion => 1;

  Stream<List<Course>> watchAllCourses(String userID) {
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

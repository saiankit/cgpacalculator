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
            path: "db.sqlite", logStatements: false));
  @override
  int get schemaVersion => 1;

  // Future<List<Course>> getAllCourses() => select(courses).get();
  Stream<List<Course>> watchAllCourses() => select(courses).watch();

  Future insertCourse(Course course) => into(courses).insert(course);
  Future updateCourse(Course course) => update(courses).replace(course);

  Future deleteCourse(Course course) => delete(courses).delete(course);

  Stream<List<Course>> watchCourseBySemesterCode(String semCode) {
    return (select(courses)
          ..where((course) => course.semesterCode.equals(semCode)))
        .watch();
  }
}

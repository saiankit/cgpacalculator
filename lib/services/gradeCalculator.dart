import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:provider/provider.dart';

class GradeCalculator {
  calcSemesterGPA(String semCode) {
    List<Course> semCourseList = [];
    AppDatabase().getCoursesBySemesterCode(semCode);
  }
}

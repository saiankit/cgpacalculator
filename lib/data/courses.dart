class Course {
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseGrade;
  Course({this.courseCode, this.courseGrade, this.courseID, this.courseTitle});
}

final courses = <Course>[
  Course(
    courseCode: 'BIO',
    courseID: 'F110',
    courseTitle: 'Biology Laboratory',
    courseGrade: 10,
  ),
  Course(
    courseCode: 'BIO',
    courseID: 'F111',
    courseTitle: 'General Biology',
    courseGrade: 9,
  ),
  Course(
    courseCode: 'BITS',
    courseID: 'F110',
    courseTitle: 'Engineering Graphics',
    courseGrade: 10,
  ),
  Course(
    courseCode: 'BITS',
    courseID: 'F111',
    courseTitle: 'Thermodynamics',
    courseGrade: 8,
  ),
  Course(
    courseCode: 'BITS',
    courseID: 'F112',
    courseTitle: 'Technical Report Writing',
    courseGrade: 8,
  ),
  Course(
    courseCode: 'CS',
    courseID: 'F111',
    courseTitle: 'Computer Programming',
    courseGrade: 8,
  ),
  Course(
    courseCode: 'MATH',
    courseID: 'F111',
    courseTitle: 'Mathematics 1',
    courseGrade: 7,
  )
];

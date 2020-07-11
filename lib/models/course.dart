// class Course {
//   String key;
//   String courseID;
//   String courseCode;
//   String courseTitle;
//   String courseCredits;
//   String gradeAchieved;

//   Course(
//       {this.courseCode,
//       this.courseCredits,
//       this.courseID,
//       this.courseTitle,
//       this.gradeAchieved,
//       this.key});

//   Course.fromSnapshot(DataSnapshot snapshot)
//       : key = snapshot.key,
//         courseID = snapshot.value['courseID'],
//         courseCode = snapshot.value['courseCode'],
//         courseTitle = snapshot.value['courseTitle'],
//         courseCredits = snapshot.value['courseCredits'],
//         gradeAchieved = snapshot.value['gradeAchieved'];

//   toJson() {
//     return {
//       "courseID": courseID,
//       "courseCode": courseCode,
//       "courseTitle": courseTitle,
//       "courseCredits": courseTitle,
//       "gradeAchieved": gradeAchieved,
//     };
//   }
// }

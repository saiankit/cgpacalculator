class CourseViewModel {
  int gradeInNumerics = 10;
  String gradeInLetters = 'A';
  static int mapToNumberGrades(String letterGrade) {
    int numericalGrade = 10;
    switch (letterGrade) {
      case "A":
        {
          numericalGrade = 10;
        }
        break;

      case "A-":
        {
          numericalGrade = 9;
        }
        break;
      case "B":
        {
          numericalGrade = 8;
        }
        break;
      case "B-":
        {
          numericalGrade = 7;
        }
        break;
      case "C":
        {
          numericalGrade = 6;
        }
        break;
      case "C-":
        {
          numericalGrade = 5;
        }
        break;
      case "D":
        {
          numericalGrade = 4;
        }
        break;
      case "E":
        {
          numericalGrade = 2;
        }
        break;
      case "CLR":
        {
          numericalGrade = 0;
        }
        break;

      default:
        {
          numericalGrade = 10;
        }
        break;
    }
    return numericalGrade;
  }

  static String mapToLetterGrades(int numericalGrade) {
    String letterGrade = "A";
    switch (numericalGrade) {
      case 10:
        {
          letterGrade = "A";
        }
        break;

      case 9:
        {
          letterGrade = "A-";
        }
        break;
      case 8:
        {
          letterGrade = "B";
        }
        break;
      case 7:
        {
          letterGrade = "B-";
        }
        break;
      case 6:
        {
          letterGrade = "C";
        }
        break;
      case 5:
        {
          letterGrade = "C-";
        }
        break;
      case 4:
        {
          letterGrade = "D";
        }
        break;
      case 2:
        {
          letterGrade = "E";
        }
        break;
      case 0:
        {
          letterGrade = "CLR";
        }
        break;

      default:
        {
          letterGrade = "A";
        }
        break;
    }
    return letterGrade;
  }
}

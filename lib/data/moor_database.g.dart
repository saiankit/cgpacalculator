// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Course extends DataClass implements Insertable<Course> {
  final int id;
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final String semesterCode;
  final int courseCredits;
  final int gradeAchieved;
  Course(
      {@required this.id,
      @required this.courseCode,
      @required this.courseID,
      @required this.courseTitle,
      @required this.semesterCode,
      @required this.courseCredits,
      @required this.gradeAchieved});
  factory Course.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Course(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      courseCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}course_code']),
      courseID: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}course_i_d']),
      courseTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}course_title']),
      semesterCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}semester_code']),
      courseCredits: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}course_credits']),
      gradeAchieved: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}grade_achieved']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || courseCode != null) {
      map['course_code'] = Variable<String>(courseCode);
    }
    if (!nullToAbsent || courseID != null) {
      map['course_i_d'] = Variable<String>(courseID);
    }
    if (!nullToAbsent || courseTitle != null) {
      map['course_title'] = Variable<String>(courseTitle);
    }
    if (!nullToAbsent || semesterCode != null) {
      map['semester_code'] = Variable<String>(semesterCode);
    }
    if (!nullToAbsent || courseCredits != null) {
      map['course_credits'] = Variable<int>(courseCredits);
    }
    if (!nullToAbsent || gradeAchieved != null) {
      map['grade_achieved'] = Variable<int>(gradeAchieved);
    }
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      courseCode: courseCode == null && nullToAbsent
          ? const Value.absent()
          : Value(courseCode),
      courseID: courseID == null && nullToAbsent
          ? const Value.absent()
          : Value(courseID),
      courseTitle: courseTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(courseTitle),
      semesterCode: semesterCode == null && nullToAbsent
          ? const Value.absent()
          : Value(semesterCode),
      courseCredits: courseCredits == null && nullToAbsent
          ? const Value.absent()
          : Value(courseCredits),
      gradeAchieved: gradeAchieved == null && nullToAbsent
          ? const Value.absent()
          : Value(gradeAchieved),
    );
  }

  factory Course.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<int>(json['id']),
      courseCode: serializer.fromJson<String>(json['courseCode']),
      courseID: serializer.fromJson<String>(json['courseID']),
      courseTitle: serializer.fromJson<String>(json['courseTitle']),
      semesterCode: serializer.fromJson<String>(json['semesterCode']),
      courseCredits: serializer.fromJson<int>(json['courseCredits']),
      gradeAchieved: serializer.fromJson<int>(json['gradeAchieved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'courseCode': serializer.toJson<String>(courseCode),
      'courseID': serializer.toJson<String>(courseID),
      'courseTitle': serializer.toJson<String>(courseTitle),
      'semesterCode': serializer.toJson<String>(semesterCode),
      'courseCredits': serializer.toJson<int>(courseCredits),
      'gradeAchieved': serializer.toJson<int>(gradeAchieved),
    };
  }

  Course copyWith(
          {int id,
          String courseCode,
          String courseID,
          String courseTitle,
          String semesterCode,
          int courseCredits,
          int gradeAchieved}) =>
      Course(
        id: id ?? this.id,
        courseCode: courseCode ?? this.courseCode,
        courseID: courseID ?? this.courseID,
        courseTitle: courseTitle ?? this.courseTitle,
        semesterCode: semesterCode ?? this.semesterCode,
        courseCredits: courseCredits ?? this.courseCredits,
        gradeAchieved: gradeAchieved ?? this.gradeAchieved,
      );
  @override
  String toString() {
    return (StringBuffer('Course(')
          ..write('id: $id, ')
          ..write('courseCode: $courseCode, ')
          ..write('courseID: $courseID, ')
          ..write('courseTitle: $courseTitle, ')
          ..write('semesterCode: $semesterCode, ')
          ..write('courseCredits: $courseCredits, ')
          ..write('gradeAchieved: $gradeAchieved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          courseCode.hashCode,
          $mrjc(
              courseID.hashCode,
              $mrjc(
                  courseTitle.hashCode,
                  $mrjc(
                      semesterCode.hashCode,
                      $mrjc(
                          courseCredits.hashCode, gradeAchieved.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.courseCode == this.courseCode &&
          other.courseID == this.courseID &&
          other.courseTitle == this.courseTitle &&
          other.semesterCode == this.semesterCode &&
          other.courseCredits == this.courseCredits &&
          other.gradeAchieved == this.gradeAchieved);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<int> id;
  final Value<String> courseCode;
  final Value<String> courseID;
  final Value<String> courseTitle;
  final Value<String> semesterCode;
  final Value<int> courseCredits;
  final Value<int> gradeAchieved;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.courseCode = const Value.absent(),
    this.courseID = const Value.absent(),
    this.courseTitle = const Value.absent(),
    this.semesterCode = const Value.absent(),
    this.courseCredits = const Value.absent(),
    this.gradeAchieved = const Value.absent(),
  });
  CoursesCompanion.insert({
    this.id = const Value.absent(),
    @required String courseCode,
    @required String courseID,
    @required String courseTitle,
    @required String semesterCode,
    @required int courseCredits,
    @required int gradeAchieved,
  })  : courseCode = Value(courseCode),
        courseID = Value(courseID),
        courseTitle = Value(courseTitle),
        semesterCode = Value(semesterCode),
        courseCredits = Value(courseCredits),
        gradeAchieved = Value(gradeAchieved);
  static Insertable<Course> custom({
    Expression<int> id,
    Expression<String> courseCode,
    Expression<String> courseID,
    Expression<String> courseTitle,
    Expression<String> semesterCode,
    Expression<int> courseCredits,
    Expression<int> gradeAchieved,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseCode != null) 'course_code': courseCode,
      if (courseID != null) 'course_i_d': courseID,
      if (courseTitle != null) 'course_title': courseTitle,
      if (semesterCode != null) 'semester_code': semesterCode,
      if (courseCredits != null) 'course_credits': courseCredits,
      if (gradeAchieved != null) 'grade_achieved': gradeAchieved,
    });
  }

  CoursesCompanion copyWith(
      {Value<int> id,
      Value<String> courseCode,
      Value<String> courseID,
      Value<String> courseTitle,
      Value<String> semesterCode,
      Value<int> courseCredits,
      Value<int> gradeAchieved}) {
    return CoursesCompanion(
      id: id ?? this.id,
      courseCode: courseCode ?? this.courseCode,
      courseID: courseID ?? this.courseID,
      courseTitle: courseTitle ?? this.courseTitle,
      semesterCode: semesterCode ?? this.semesterCode,
      courseCredits: courseCredits ?? this.courseCredits,
      gradeAchieved: gradeAchieved ?? this.gradeAchieved,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (courseCode.present) {
      map['course_code'] = Variable<String>(courseCode.value);
    }
    if (courseID.present) {
      map['course_i_d'] = Variable<String>(courseID.value);
    }
    if (courseTitle.present) {
      map['course_title'] = Variable<String>(courseTitle.value);
    }
    if (semesterCode.present) {
      map['semester_code'] = Variable<String>(semesterCode.value);
    }
    if (courseCredits.present) {
      map['course_credits'] = Variable<int>(courseCredits.value);
    }
    if (gradeAchieved.present) {
      map['grade_achieved'] = Variable<int>(gradeAchieved.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('courseCode: $courseCode, ')
          ..write('courseID: $courseID, ')
          ..write('courseTitle: $courseTitle, ')
          ..write('semesterCode: $semesterCode, ')
          ..write('courseCredits: $courseCredits, ')
          ..write('gradeAchieved: $gradeAchieved')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
  final GeneratedDatabase _db;
  final String _alias;
  $CoursesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _courseCodeMeta = const VerificationMeta('courseCode');
  GeneratedTextColumn _courseCode;
  @override
  GeneratedTextColumn get courseCode => _courseCode ??= _constructCourseCode();
  GeneratedTextColumn _constructCourseCode() {
    return GeneratedTextColumn(
      'course_code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _courseIDMeta = const VerificationMeta('courseID');
  GeneratedTextColumn _courseID;
  @override
  GeneratedTextColumn get courseID => _courseID ??= _constructCourseID();
  GeneratedTextColumn _constructCourseID() {
    return GeneratedTextColumn(
      'course_i_d',
      $tableName,
      false,
    );
  }

  final VerificationMeta _courseTitleMeta =
      const VerificationMeta('courseTitle');
  GeneratedTextColumn _courseTitle;
  @override
  GeneratedTextColumn get courseTitle =>
      _courseTitle ??= _constructCourseTitle();
  GeneratedTextColumn _constructCourseTitle() {
    return GeneratedTextColumn(
      'course_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _semesterCodeMeta =
      const VerificationMeta('semesterCode');
  GeneratedTextColumn _semesterCode;
  @override
  GeneratedTextColumn get semesterCode =>
      _semesterCode ??= _constructSemesterCode();
  GeneratedTextColumn _constructSemesterCode() {
    return GeneratedTextColumn(
      'semester_code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _courseCreditsMeta =
      const VerificationMeta('courseCredits');
  GeneratedIntColumn _courseCredits;
  @override
  GeneratedIntColumn get courseCredits =>
      _courseCredits ??= _constructCourseCredits();
  GeneratedIntColumn _constructCourseCredits() {
    return GeneratedIntColumn(
      'course_credits',
      $tableName,
      false,
    );
  }

  final VerificationMeta _gradeAchievedMeta =
      const VerificationMeta('gradeAchieved');
  GeneratedIntColumn _gradeAchieved;
  @override
  GeneratedIntColumn get gradeAchieved =>
      _gradeAchieved ??= _constructGradeAchieved();
  GeneratedIntColumn _constructGradeAchieved() {
    return GeneratedIntColumn(
      'grade_achieved',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        courseCode,
        courseID,
        courseTitle,
        semesterCode,
        courseCredits,
        gradeAchieved
      ];
  @override
  $CoursesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'courses';
  @override
  final String actualTableName = 'courses';
  @override
  VerificationContext validateIntegrity(Insertable<Course> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('course_code')) {
      context.handle(
          _courseCodeMeta,
          courseCode.isAcceptableOrUnknown(
              data['course_code'], _courseCodeMeta));
    } else if (isInserting) {
      context.missing(_courseCodeMeta);
    }
    if (data.containsKey('course_i_d')) {
      context.handle(_courseIDMeta,
          courseID.isAcceptableOrUnknown(data['course_i_d'], _courseIDMeta));
    } else if (isInserting) {
      context.missing(_courseIDMeta);
    }
    if (data.containsKey('course_title')) {
      context.handle(
          _courseTitleMeta,
          courseTitle.isAcceptableOrUnknown(
              data['course_title'], _courseTitleMeta));
    } else if (isInserting) {
      context.missing(_courseTitleMeta);
    }
    if (data.containsKey('semester_code')) {
      context.handle(
          _semesterCodeMeta,
          semesterCode.isAcceptableOrUnknown(
              data['semester_code'], _semesterCodeMeta));
    } else if (isInserting) {
      context.missing(_semesterCodeMeta);
    }
    if (data.containsKey('course_credits')) {
      context.handle(
          _courseCreditsMeta,
          courseCredits.isAcceptableOrUnknown(
              data['course_credits'], _courseCreditsMeta));
    } else if (isInserting) {
      context.missing(_courseCreditsMeta);
    }
    if (data.containsKey('grade_achieved')) {
      context.handle(
          _gradeAchievedMeta,
          gradeAchieved.isAcceptableOrUnknown(
              data['grade_achieved'], _gradeAchievedMeta));
    } else if (isInserting) {
      context.missing(_gradeAchievedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Course map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Course.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CoursesTable _courses;
  $CoursesTable get courses => _courses ??= $CoursesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [courses];
}

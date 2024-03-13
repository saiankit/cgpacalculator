// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database_service.dart';

// ignore_for_file: type=lint
class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _courseCodeMeta =
      const VerificationMeta('courseCode');
  @override
  late final GeneratedColumn<String> courseCode = GeneratedColumn<String>(
      'course_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _courseIDMeta =
      const VerificationMeta('courseID');
  @override
  late final GeneratedColumn<String> courseID = GeneratedColumn<String>(
      'course_i_d', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _courseTitleMeta =
      const VerificationMeta('courseTitle');
  @override
  late final GeneratedColumn<String> courseTitle = GeneratedColumn<String>(
      'course_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _semesterCodeMeta =
      const VerificationMeta('semesterCode');
  @override
  late final GeneratedColumn<String> semesterCode = GeneratedColumn<String>(
      'semester_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _courseCreditsMeta =
      const VerificationMeta('courseCredits');
  @override
  late final GeneratedColumn<int> courseCredits = GeneratedColumn<int>(
      'course_credits', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _gradeAchievedMeta =
      const VerificationMeta('gradeAchieved');
  @override
  late final GeneratedColumn<int> gradeAchieved = GeneratedColumn<int>(
      'grade_achieved', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userIDMeta = const VerificationMeta('userID');
  @override
  late final GeneratedColumn<String> userID = GeneratedColumn<String>(
      'user_i_d', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        courseCode,
        courseID,
        courseTitle,
        semesterCode,
        courseCredits,
        gradeAchieved,
        userID
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(Insertable<Course> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('course_code')) {
      context.handle(
          _courseCodeMeta,
          courseCode.isAcceptableOrUnknown(
              data['course_code']!, _courseCodeMeta));
    } else if (isInserting) {
      context.missing(_courseCodeMeta);
    }
    if (data.containsKey('course_i_d')) {
      context.handle(_courseIDMeta,
          courseID.isAcceptableOrUnknown(data['course_i_d']!, _courseIDMeta));
    } else if (isInserting) {
      context.missing(_courseIDMeta);
    }
    if (data.containsKey('course_title')) {
      context.handle(
          _courseTitleMeta,
          courseTitle.isAcceptableOrUnknown(
              data['course_title']!, _courseTitleMeta));
    } else if (isInserting) {
      context.missing(_courseTitleMeta);
    }
    if (data.containsKey('semester_code')) {
      context.handle(
          _semesterCodeMeta,
          semesterCode.isAcceptableOrUnknown(
              data['semester_code']!, _semesterCodeMeta));
    } else if (isInserting) {
      context.missing(_semesterCodeMeta);
    }
    if (data.containsKey('course_credits')) {
      context.handle(
          _courseCreditsMeta,
          courseCredits.isAcceptableOrUnknown(
              data['course_credits']!, _courseCreditsMeta));
    } else if (isInserting) {
      context.missing(_courseCreditsMeta);
    }
    if (data.containsKey('grade_achieved')) {
      context.handle(
          _gradeAchievedMeta,
          gradeAchieved.isAcceptableOrUnknown(
              data['grade_achieved']!, _gradeAchievedMeta));
    } else if (isInserting) {
      context.missing(_gradeAchievedMeta);
    }
    if (data.containsKey('user_i_d')) {
      context.handle(_userIDMeta,
          userID.isAcceptableOrUnknown(data['user_i_d']!, _userIDMeta));
    } else if (isInserting) {
      context.missing(_userIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      courseCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}course_code'])!,
      courseID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}course_i_d'])!,
      courseTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}course_title'])!,
      semesterCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}semester_code'])!,
      courseCredits: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}course_credits'])!,
      gradeAchieved: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grade_achieved'])!,
      userID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_i_d'])!,
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class Course extends DataClass implements Insertable<Course> {
  final int id;
  final String courseCode;
  final String courseID;
  final String courseTitle;
  final String semesterCode;
  final int courseCredits;
  final int gradeAchieved;
  final String userID;
  const Course(
      {required this.id,
      required this.courseCode,
      required this.courseID,
      required this.courseTitle,
      required this.semesterCode,
      required this.courseCredits,
      required this.gradeAchieved,
      required this.userID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['course_code'] = Variable<String>(courseCode);
    map['course_i_d'] = Variable<String>(courseID);
    map['course_title'] = Variable<String>(courseTitle);
    map['semester_code'] = Variable<String>(semesterCode);
    map['course_credits'] = Variable<int>(courseCredits);
    map['grade_achieved'] = Variable<int>(gradeAchieved);
    map['user_i_d'] = Variable<String>(userID);
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      courseCode: Value(courseCode),
      courseID: Value(courseID),
      courseTitle: Value(courseTitle),
      semesterCode: Value(semesterCode),
      courseCredits: Value(courseCredits),
      gradeAchieved: Value(gradeAchieved),
      userID: Value(userID),
    );
  }

  factory Course.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<int>(json['id']),
      courseCode: serializer.fromJson<String>(json['courseCode']),
      courseID: serializer.fromJson<String>(json['courseID']),
      courseTitle: serializer.fromJson<String>(json['courseTitle']),
      semesterCode: serializer.fromJson<String>(json['semesterCode']),
      courseCredits: serializer.fromJson<int>(json['courseCredits']),
      gradeAchieved: serializer.fromJson<int>(json['gradeAchieved']),
      userID: serializer.fromJson<String>(json['userID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'courseCode': serializer.toJson<String>(courseCode),
      'courseID': serializer.toJson<String>(courseID),
      'courseTitle': serializer.toJson<String>(courseTitle),
      'semesterCode': serializer.toJson<String>(semesterCode),
      'courseCredits': serializer.toJson<int>(courseCredits),
      'gradeAchieved': serializer.toJson<int>(gradeAchieved),
      'userID': serializer.toJson<String>(userID),
    };
  }

  Course copyWith(
          {int? id,
          String? courseCode,
          String? courseID,
          String? courseTitle,
          String? semesterCode,
          int? courseCredits,
          int? gradeAchieved,
          String? userID}) =>
      Course(
        id: id ?? this.id,
        courseCode: courseCode ?? this.courseCode,
        courseID: courseID ?? this.courseID,
        courseTitle: courseTitle ?? this.courseTitle,
        semesterCode: semesterCode ?? this.semesterCode,
        courseCredits: courseCredits ?? this.courseCredits,
        gradeAchieved: gradeAchieved ?? this.gradeAchieved,
        userID: userID ?? this.userID,
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
          ..write('gradeAchieved: $gradeAchieved, ')
          ..write('userID: $userID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, courseCode, courseID, courseTitle,
      semesterCode, courseCredits, gradeAchieved, userID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.courseCode == this.courseCode &&
          other.courseID == this.courseID &&
          other.courseTitle == this.courseTitle &&
          other.semesterCode == this.semesterCode &&
          other.courseCredits == this.courseCredits &&
          other.gradeAchieved == this.gradeAchieved &&
          other.userID == this.userID);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<int> id;
  final Value<String> courseCode;
  final Value<String> courseID;
  final Value<String> courseTitle;
  final Value<String> semesterCode;
  final Value<int> courseCredits;
  final Value<int> gradeAchieved;
  final Value<String> userID;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.courseCode = const Value.absent(),
    this.courseID = const Value.absent(),
    this.courseTitle = const Value.absent(),
    this.semesterCode = const Value.absent(),
    this.courseCredits = const Value.absent(),
    this.gradeAchieved = const Value.absent(),
    this.userID = const Value.absent(),
  });
  CoursesCompanion.insert({
    this.id = const Value.absent(),
    required String courseCode,
    required String courseID,
    required String courseTitle,
    required String semesterCode,
    required int courseCredits,
    required int gradeAchieved,
    required String userID,
  })  : courseCode = Value(courseCode),
        courseID = Value(courseID),
        courseTitle = Value(courseTitle),
        semesterCode = Value(semesterCode),
        courseCredits = Value(courseCredits),
        gradeAchieved = Value(gradeAchieved),
        userID = Value(userID);
  static Insertable<Course> custom({
    Expression<int>? id,
    Expression<String>? courseCode,
    Expression<String>? courseID,
    Expression<String>? courseTitle,
    Expression<String>? semesterCode,
    Expression<int>? courseCredits,
    Expression<int>? gradeAchieved,
    Expression<String>? userID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseCode != null) 'course_code': courseCode,
      if (courseID != null) 'course_i_d': courseID,
      if (courseTitle != null) 'course_title': courseTitle,
      if (semesterCode != null) 'semester_code': semesterCode,
      if (courseCredits != null) 'course_credits': courseCredits,
      if (gradeAchieved != null) 'grade_achieved': gradeAchieved,
      if (userID != null) 'user_i_d': userID,
    });
  }

  CoursesCompanion copyWith(
      {Value<int>? id,
      Value<String>? courseCode,
      Value<String>? courseID,
      Value<String>? courseTitle,
      Value<String>? semesterCode,
      Value<int>? courseCredits,
      Value<int>? gradeAchieved,
      Value<String>? userID}) {
    return CoursesCompanion(
      id: id ?? this.id,
      courseCode: courseCode ?? this.courseCode,
      courseID: courseID ?? this.courseID,
      courseTitle: courseTitle ?? this.courseTitle,
      semesterCode: semesterCode ?? this.semesterCode,
      courseCredits: courseCredits ?? this.courseCredits,
      gradeAchieved: gradeAchieved ?? this.gradeAchieved,
      userID: userID ?? this.userID,
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
    if (userID.present) {
      map['user_i_d'] = Variable<String>(userID.value);
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
          ..write('gradeAchieved: $gradeAchieved, ')
          ..write('userID: $userID')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $CoursesTable courses = $CoursesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [courses];
}

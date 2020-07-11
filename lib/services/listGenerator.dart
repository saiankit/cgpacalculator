import 'package:CgpaCalculator/components/noItemsOops.dart';
import 'package:CgpaCalculator/services/auth.dart';
import 'package:CgpaCalculator/widgets/courseCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListGenerator extends StatefulWidget {
  final String semesterCode;
  ListGenerator({this.semesterCode});
  @override
  _ListGeneratorState createState() => _ListGeneratorState();
}

class _ListGeneratorState extends State<ListGenerator> {
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: _firestore
              .collection("users")
              .where('userID', isEqualTo: authService.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            // print(snapshot.data.documents);
            if (snapshot.data.documents.isEmpty) return NoItemsOops();
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return CourseCard(
                  courseCode: snapshot.data.documents[index]
                      [widget.semesterCode]['course']['courseCode'],
                  gradeAchieved: snapshot.data.documents[index]
                      [widget.semesterCode]['course']['gradeAchieved'],
                  courseID: snapshot.data.documents[index][widget.semesterCode]
                      ['course']['courseID'],
                  courseTitle: snapshot.data.documents[index]
                      [widget.semesterCode]['course']['courseTitle'],
                  courseCredits: snapshot.data.documents[index]
                      [widget.semesterCode]['course']['courseCredits'],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

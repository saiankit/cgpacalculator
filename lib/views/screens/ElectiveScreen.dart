import 'package:flutter/material.dart';

class ElectiveScreen extends StatefulWidget {
  final String title;

  const ElectiveScreen({Key key, this.title}) : super(key: key);
  @override
  _ElectiveScreenState createState() => _ElectiveScreenState();
}

class _ElectiveScreenState extends State<ElectiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('My ${widget.title} Electives'),
          ],
        ),
      ),
    );
  }
}

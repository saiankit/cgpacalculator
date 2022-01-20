import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/theme_styles.dart';

class ExportCSVScreen extends StatefulWidget {
  const ExportCSVScreen({Key? key}) : super(key: key);

  @override
  _ExportCSVScreenState createState() => _ExportCSVScreenState();
}

class _ExportCSVScreenState extends State<ExportCSVScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: CustomIcons.arrowBackIOS,
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(),
    );
  }
}

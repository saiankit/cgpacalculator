import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/theme_styles.dart';

class ImportCSVScreen extends StatefulWidget {
  const ImportCSVScreen({Key? key}) : super(key: key);

  @override
  _ImportCSVScreenState createState() => _ImportCSVScreenState();
}

class _ImportCSVScreenState extends State<ImportCSVScreen> {
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

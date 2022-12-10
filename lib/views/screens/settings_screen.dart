import 'package:cgpacalculator/views/screens/export_csv.dart';
import 'package:cgpacalculator/views/screens/import_csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../data/course_meta_data.dart';
import '../../services/authentication_service.dart';
import '../../services/user_details_view_model.dart';
import '../../utilities/theme_styles.dart';
import 'analytics_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String primaryDiscipline = 'None';
  String secondaryDiscipline = 'None';
  String minorDiscipline = 'None';
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          primaryDiscipline = Provider.of<UserDetails>(context, listen: false)
              .primaryDiscipline;
          secondaryDiscipline = Provider.of<UserDetails>(context, listen: false)
              .secondaryDiscipline;
          minorDiscipline =
              Provider.of<UserDetails>(context, listen: false).minorDiscipline;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Consumer<UserDetails>(
            builder: (context, userDetails, _) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(Converts.c20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: Converts.c40,
                            width: Converts.c40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: Icon(Icons.book),
                          ),
                          SizedBox(width: Converts.c16),
                          Text(
                            'Discipline',
                            style: ThemeStyles.t20TextStyle.copyWith(
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          SizedBox(width: Converts.c16),
                        ],
                      ),
                      Container(
                        height: Converts.c48,
                        width: Converts.c104,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(Converts.c8),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Converts.c8),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            style: ThemeStyles.t20TextStyle,
                            underline: Container(),
                            value: primaryDiscipline,
                            items: primaryDisciplineList
                                .map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: ThemeStyles.t20TextStyle,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                primaryDiscipline = value!;
                              });
                              userDetails.changePrimaryDiscipline(value!);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Converts.c20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: Converts.c40,
                            width: Converts.c40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: Icon(Icons.book),
                          ),
                          SizedBox(width: Converts.c16),
                          Text(
                            'Dual Discipline',
                            style: ThemeStyles.t20TextStyle.copyWith(
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          SizedBox(width: Converts.c16),
                        ],
                      ),
                      Container(
                        height: Converts.c48,
                        width: Converts.c104,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(Converts.c8),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Converts.c8),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            style: ThemeStyles.t20TextStyle,
                            underline: Container(),
                            value: secondaryDiscipline,
                            items: secondaryDisciplineList
                                .map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value,
                                      style: ThemeStyles.t20TextStyle),
                                );
                              },
                            ).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                secondaryDiscipline = value!;
                              });
                              userDetails.changeSecondaryDiscipline(value!);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(Converts.c20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           Container(
                //             height: Converts.c40,
                //             width: Converts.c40,
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: Colors.black.withOpacity(0.1),
                //             ),
                //             child: Icon(Icons.book),
                //           ),
                //           SizedBox(width: Converts.c16),
                //           Text(
                //             'Minor',
                //             style: ThemeStyles.t20TextStyle
                //                 .copyWith(fontWeight: FontWeight.w100),
                //           ),
                //           SizedBox(width: Converts.c16),
                //         ],
                //       ),
                //       Container(
                //         height: Converts.c48,
                //         width: Converts.c200,
                //         decoration: BoxDecoration(
                //           border: Border.all(),
                //           borderRadius: BorderRadius.circular(Converts.c8),
                //         ),
                //         child: Padding(
                //           padding:
                //               EdgeInsets.symmetric(horizontal: Converts.c8),
                //           child: DropdownButton<String>(
                //             dropdownColor: Colors.white,
                //             isExpanded: true,
                //             icon: Icon(Icons.keyboard_arrow_down),
                //             style: ThemeStyles.t20TextStyle,
                //             underline: Container(),
                //             value: minorDiscipline,
                //             items: minorList.map<DropdownMenuItem<String>>(
                //               (String value) {
                //                 return DropdownMenuItem(
                //                   value: value,
                //                   child: Text(
                //                     value,
                //                     style: ThemeStyles.t16TextStyle,
                //                   ),
                //                 );
                //               },
                //             ).toList(),
                //             onChanged: (String? value) {
                //               setState(() {
                //                 minorDiscipline = value!;
                //               });
                //               userDetails.changeMinor(value!);
                //             },
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Navigator.push(
                      context,
                      PageTransition(
                        curve: Curves.easeInOutSine,
                        type: PageTransitionType.fade,
                        child: AnalyticsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(Converts.c20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: Converts.c40,
                                width: Converts.c40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                child: Icon(Icons.analytics),
                              ),
                              SizedBox(width: Converts.c16),
                              Text(
                                'Analytics',
                                style: ThemeStyles.t20TextStyle.copyWith(
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              SizedBox(width: Converts.c16),
                            ],
                          ),
                          Container(
                            height: Converts.c40,
                            width: Converts.c40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     HapticFeedback.mediumImpact();
                //     Navigator.push(
                //       context,
                //       PageTransition(
                //         curve: Curves.easeInOutSine,
                //         type: PageTransitionType.fade,
                //         child: ImportCSVScreen(),
                //       ),
                //     );
                //   },
                //   child: Container(
                //     child: Padding(
                //       padding: EdgeInsets.all(Converts.c20),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             children: [
                //               Container(
                //                 height: Converts.c40,
                //                 width: Converts.c40,
                //                 decoration: BoxDecoration(
                //                   shape: BoxShape.circle,
                //                   color: Colors.black.withOpacity(0.1),
                //                 ),
                //                 child: Icon(Icons.file_download),
                //               ),
                //               SizedBox(width: Converts.c16),
                //               Text(
                //                 'Import CSV',
                //                 style: ThemeStyles.t20TextStyle.copyWith(
                //                   fontWeight: FontWeight.w100,
                //                 ),
                //               ),
                //               SizedBox(width: Converts.c16),
                //             ],
                //           ),
                //           Container(
                //             height: Converts.c40,
                //             width: Converts.c40,
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: Colors.black.withOpacity(0.1),
                //             ),
                //             child: Icon(Icons.chevron_right),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // InkWell(
                //   onTap: () {
                //     HapticFeedback.mediumImpact();
                //     Navigator.push(
                //       context,
                //       PageTransition(
                //         curve: Curves.easeInOutSine,
                //         type: PageTransitionType.fade,
                //         child: ExportCSVScreen(),
                //       ),
                //     );
                //   },
                //   child: Container(
                //     child: Padding(
                //       padding: EdgeInsets.all(Converts.c20),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             children: [
                //               Container(
                //                 height: Converts.c40,
                //                 width: Converts.c40,
                //                 decoration: BoxDecoration(
                //                   shape: BoxShape.circle,
                //                   color: Colors.black.withOpacity(0.1),
                //                 ),
                //                 child: Icon(Icons.file_upload),
                //               ),
                //               SizedBox(width: Converts.c16),
                //               Text(
                //                 'Export CSV',
                //                 style: ThemeStyles.t20TextStyle.copyWith(
                //                   fontWeight: FontWeight.w100,
                //                 ),
                //               ),
                //               SizedBox(width: Converts.c16),
                //             ],
                //           ),
                //           Container(
                //             height: Converts.c40,
                //             width: Converts.c40,
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: Colors.black.withOpacity(0.1),
                //             ),
                //             child: Icon(Icons.chevron_right),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    showLogOutDialog(context);
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(Converts.c20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: Converts.c40,
                                width: Converts.c40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                child: Icon(
                                  Icons.power_settings_new,
                                  size: 30.0,
                                  color: Colors.redAccent,
                                ),
                              ),
                              SizedBox(width: Converts.c16),
                              Text(
                                'Log Out',
                                style: ThemeStyles.t20TextStyle.copyWith(
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              SizedBox(width: Converts.c16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout from the App ?"),
        actions: <Widget>[
          Consumer<GoogleSignInProvider>(
            builder: (context, auth, _) => TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                await auth.logOut();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ),
          TextButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

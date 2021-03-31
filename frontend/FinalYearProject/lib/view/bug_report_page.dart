import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/widgets/report_bug_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportBug extends StatefulWidget {
  final FirebaseUser user;

  const ReportBug(
    this.user,
  );

  @override
  _ReportBugState createState() => _ReportBugState();
}

class _ReportBugState extends State<ReportBug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 5.0,
          title: Text("Report Bug",
              style: TextStyle(color: Colors.white, fontSize: 30)),
          backgroundColor: waterBlueColour,
        ),
        body: ListView(
          children: [
            SizedBox(height: 60),
            ReportBugWidget(widget.user),
          ],
        ));
  }
}

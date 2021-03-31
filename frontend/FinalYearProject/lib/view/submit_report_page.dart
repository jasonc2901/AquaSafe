import 'package:FinalYearProject/view/user_account_page.dart';
import 'package:FinalYearProject/widgets/report_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SubmitReportPage extends StatefulWidget {
  final FirebaseUser user;

  const SubmitReportPage(
    this.user,
  );

  @override
  _SubmitReportPage createState() => _SubmitReportPage();
}

class _SubmitReportPage extends State<SubmitReportPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 5.0,
          title: Text("Create a report",
              style: TextStyle(color: Colors.white, fontSize: 25)),
          backgroundColor: waterBlueColour,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              iconSize: 40,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserAccountDetailsPage(
                              user: widget.user,
                            )));
              },
            )
          ],
        ),
        body: ListView(
          children: [
            SizedBox(height: 50.0),
            ReportWidget(widget.user),
          ],
        ),
      ),
    );
  }
}

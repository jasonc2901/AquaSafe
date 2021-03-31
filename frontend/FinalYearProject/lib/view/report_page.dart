import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/submit_report_page.dart';
import 'package:FinalYearProject/widgets/report_analytics_widget.dart';
import 'package:FinalYearProject/widgets/report_hub_widget.dart';
import 'package:FinalYearProject/widgets/report_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  final FirebaseUser user;

  const ReportPage(
    this.user,
  );

  @override
  _ReportPage createState() => _ReportPage();
}

class _ReportPage extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: waterBlueColour,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36.0),
                    bottomRight: Radius.circular(36.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: size.width,
                height: size.height / 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Hi there, \n${widget.user.displayName}",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.user.photoUrl),
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
            ReportAnalyticsWidget(widget.user),
            SizedBox(
              height: 20,
            ),
            ReportHubWidget(widget.user)
          ],
        ),
      ),
    );
  }
}

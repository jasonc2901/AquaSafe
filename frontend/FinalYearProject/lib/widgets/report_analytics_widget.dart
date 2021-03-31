import 'package:FinalYearProject/models/GetNumPendingModel.dart';
import 'package:FinalYearProject/models/GetNumReportsModel.dart';
import 'package:FinalYearProject/services/getNumPending.dart';
import 'package:FinalYearProject/services/getNumReports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ReportAnalyticsWidget extends StatefulWidget {
  final FirebaseUser user;

  const ReportAnalyticsWidget(
    this.user,
  );

  @override
  _ReportAnalyticsState createState() => _ReportAnalyticsState();
}

class _ReportAnalyticsState extends State<ReportAnalyticsWidget> {
  Future<GetNumReportsModel> getNumReports(String username) async {
    GetNumReports db = new GetNumReports();
    Future<GetNumReportsModel> response;
    try {
      response = db.fetchNumReports(username);

      return response;
    } on Exception catch (exception) {
      print(exception);
      return response;
    }
  }

  Future<GetNumPendingModel> getNumPending(String username) async {
    GetNumPending db = new GetNumPending();
    Future<GetNumPendingModel> response;
    try {
      response = db.fetchNumPending(username);

      return response;
    } on Exception catch (exception) {
      print(exception);
      return response;
    }
  }

  var numReports;
  var numPending;

  @override
  void initState() {
    super.initState();
    updateNumReports();
    updateNumPending();
  }

  void updateNumReports() async {
    String reportNum = "0";
    await getNumReports(widget.user.displayName).then((result) {
      reportNum = result.reports.toString();
    });

    setState(() {
      numReports = reportNum;
    });
  }

  void updateNumPending() async {
    String pendingNum = "0";
    await getNumPending(widget.user.displayName).then((result) {
      pendingNum = result.reportsPendingResponse.toString();
    });

    setState(() {
      numPending = pendingNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String reportNum = numReports;
    String pendingNum = numPending;

    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: size.height / 4,
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: waterBlueColour,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 4,
                      color: Colors.grey.withOpacity(0.7),
                      offset: Offset(0, 2),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: reportNum == null
                          ? CircularProgressIndicator()
                          : Text(
                              "$reportNum \nprevious reports submitted.",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: waterBlueColour,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 4,
                      color: Colors.grey.withOpacity(0.7),
                      offset: Offset(0, 2),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: reportNum == null
                          ? CircularProgressIndicator()
                          : Text(
                              "$pendingNum \nreports pending response.",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

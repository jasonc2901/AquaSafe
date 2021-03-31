import 'package:FinalYearProject/models/GetReportsModel.dart';
import 'package:FinalYearProject/services/getReportFromDb.dart';
import 'package:FinalYearProject/view/report_info_page.dart';
import 'package:FinalYearProject/view/user_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ViewReportsPage extends StatefulWidget {
  final FirebaseUser user;

  const ViewReportsPage(
    this.user,
  );

  @override
  _ViewReportsPageState createState() => _ViewReportsPageState();
}

class _ViewReportsPageState extends State<ViewReportsPage> {
  Future<GetReportsModel> getReports(String username) async {
    GetReportFromDb db = new GetReportFromDb();
    Future<GetReportsModel> response;
    try {
      response = db.fetchReport(username);

      return response;
    } on Exception catch (exception) {
      print(exception);
      return response;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _reports = Provider.of<Future<GetReportsModel>>(context);
    // print(_reports);
    return Container(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 5.0,
            title: Text("View reports",
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
          body: FutureBuilder(
            future: getReports(widget.user.displayName),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? snapshot.data.reports.length < 1
                      ? Center(
                          child: Text(
                            "No submitted reports",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            snapshot.data.reports.length > 0
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "Previous Reports",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30,
                                      ),
                                    ),
                                  )
                                : Text(
                                    "No previous Reports",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30,
                                    ),
                                  ),
                            SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    (snapshot.data.reports.length != null)
                                        ? snapshot.data.reports.length
                                        : 0,
                                itemBuilder: (context, i) {
                                  Reports report = snapshot.data.reports[i];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Card(
                                      child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReportInfoPage(
                                                        report: report,
                                                        user: widget.user),
                                              ),
                                            );
                                          },
                                          title: Text(
                                            report.subject,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                          subtitle: Text(
                                            report.body,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          trailing: Text(
                                            report.date,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          )),
    );
  }
}

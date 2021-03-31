import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/user_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportInfoPage extends StatefulWidget {
  final report;
  final FirebaseUser user;

  ReportInfoPage({Key key, @required this.report, @required this.user})
      : super(key: key);

  @override
  ReportInfoPageState createState() => ReportInfoPageState();
}

class ReportInfoPageState extends State<ReportInfoPage> {
  @override
  Widget build(BuildContext context) {
    var pageSize = MediaQuery.of(context).size;
    return Container(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              elevation: 5.0,
              title: Text(widget.report.subject,
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
            body: SingleChildScrollView(
              child: Column(children: [
                Container(
                  height: pageSize.height / 8,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Report created on " "${widget.report.date}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: pageSize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5.0,
                          offset: Offset(0.0, 0.75),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Subject",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.report.subject}",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: pageSize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5.0,
                          offset: Offset(0.0, 0.75),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Body",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.report.body}",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            )));
  }
}

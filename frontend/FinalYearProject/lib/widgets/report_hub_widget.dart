import 'package:FinalYearProject/view/submit_report_page.dart';
import 'package:FinalYearProject/view/view_reports_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class ReportHubWidget extends StatefulWidget {
  final FirebaseUser user;

  const ReportHubWidget(
    this.user,
  );

  @override
  _ReportHubWidgetState createState() => _ReportHubWidgetState();
}

class _ReportHubWidgetState extends State<ReportHubWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: size.height / 3.8,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 50.0,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Reporting Hub",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color: waterBlueColour,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 4,
                            color: Colors.grey.withOpacity(0.7),
                            offset: Offset(0, 2),
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        )),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SubmitReportPage(widget.user)));
                      },
                      child: Container(
                        height: size.height / 6.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  FontAwesome5Solid.comment,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                              Text(
                                "Create report",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewReportsPage(widget.user)));
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: waterBlueColour,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 4,
                              color: Colors.grey.withOpacity(0.7),
                              offset: Offset(0, 2),
                              blurRadius: 3,
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          )),
                      child: Container(
                        height: size.height / 6.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    FontAwesome5Solid.database,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                "View reports",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

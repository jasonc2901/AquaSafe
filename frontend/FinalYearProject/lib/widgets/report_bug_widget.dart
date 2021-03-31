import 'package:FinalYearProject/CustomDialog/CustomDialog.dart';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/models/BugReportModel.dart';
import 'package:FinalYearProject/services/postBugReportToDb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportBugWidget extends StatefulWidget {
  final FirebaseUser user;

  const ReportBugWidget(
    this.user,
  );

  @override
  _ReportBugWidgetState createState() => _ReportBugWidgetState();
}

class _ReportBugWidgetState extends State<ReportBugWidget> {
  final GlobalKey<FormState> _reportKey = GlobalKey<FormState>();

  final _bugTitle = TextEditingController();
  final _regularOccurence = TextEditingController();
  final _bugDescription = TextEditingController();

  // Function which shows the success Message
  void showSuccess() {
    showDialog(
        context: (context),
        child: CustomDialog(
            title: "Report Submitted",
            description: "Your report has been submitted successfully",
            buttonText: "Close",
            alertImage: "assets/tick.png",
            buttonColor: Colors.green[300]));
  }

  // Function which shows the missing field error message
  void showMissingFieldError() {
    showDialog(
        context: (context),
        child: CustomDialog(
            title: "Blank field",
            description: "Your report cannot have any blank fields! Try again",
            buttonText: "Close",
            alertImage: "assets/x.png",
            buttonColor: Colors.red[600]));
  }

  //the function that handles the posting of the bug report to the db
  Future<BugReportModel> postBugReport(String username, String subject,
      String body, String frequency, String date, String email) async {
    ReportBugToDb db = new ReportBugToDb();
    Future<BugReportModel> response;
    try {
      if (_bugTitle.text.length < 1 ||
          _bugDescription.text.length < 1 ||
          _regularOccurence.text.length < 1) {
        showMissingFieldError();
      } else {
        //create the response object from the model
        response =
            db.postBugReport(username, subject, body, frequency, date, email);
        response.then((response) {
          print(response.status);
        });
        //show success when added to db
        showSuccess();
        //reset the field values
        resetPage();
        return response;
      }
    } on Exception catch (exception) {
      print(exception);
      return response;
    }
    return response;
  }

  //Function which will reset the page state when an email is sent.
  resetPage() {
    setState(() {
      _bugTitle.text = "";
      _bugDescription.text = "";
      _regularOccurence.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    String username = widget.user.displayName;
    DateTime now = new DateTime.now();
    var dateFormatter = new DateFormat.yMMMMEEEEd('en_us');
    String todaysDate = dateFormatter.format(now);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: widthSize,
        height: heightSize / 1.45,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                "Report a Bug",
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _reportKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _bugTitle,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Bug Title...",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _bugDescription,
                        maxLines: 10,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Bug Description..."),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _regularOccurence,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Is this a regular occurence?"),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      onPressed: () async {
                        if (_reportKey.currentState.validate()) {
                          await postBugReport(
                              username,
                              _bugTitle.text,
                              _bugDescription.text,
                              _regularOccurence.text,
                              todaysDate,
                              widget.user.email);
                        }
                      },
                      color: waterBlueColour,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

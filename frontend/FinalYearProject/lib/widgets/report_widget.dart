import 'dart:io';
import 'package:FinalYearProject/CustomDialog/CustomDialog.dart';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/models/ReportModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:FinalYearProject/services/postReportToDb.dart';

class ReportWidget extends StatefulWidget {
  final FirebaseUser user;

  const ReportWidget(
    this.user,
  );

  @override
  _ReportWidgetState createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  //declare all global variables
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _recipients = ["bcraig7878@gmail.com", "jasoncaughers@gmail.com"];
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  File _image;
  String attatchmentPath;
  String imageSelectBtnText = "Attach Image";
  bool isEnabled = true;

  //function that launches the image selection function
  imageFunction() async {
    pickImageFromGallery();
  }

  //the function to handle the disable button click events
  disableButton() {
    setState(() {
      isEnabled = false;
      imageSelectBtnText = "Image attached!";
    });
  }

  //re enable the button when page is reset
  enableButton() {
    setState(() {
      isEnabled = true;
      imageSelectBtnText = "Attach Image";
    });
  }

  //function that handles opening the gallery and selecting an image to attach
  Future pickImageFromGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile;
      attatchmentPath = _image.path;
    });

    //disables the button only once the image has been selected
    if (imageFile != null) {
      showDialog(
        context: context,
        child: CustomDialog(
            title: "Image Attached!",
            description: "You have attached an image successfully",
            buttonText: "Close",
            alertImage: "assets/tick.png",
            buttonColor: Colors.green[400]),
      );
      disableButton();
    }
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

  Future<ReportModel> postUserReport(String username, String subject,
      String body, String date, String email, String pending) async {
    ReportToDb db = new ReportToDb();
    Future<ReportModel> response;
    try {
      if (_subjectController.text.length < 1 ||
          _bodyController.text.length < 1 ||
          _image == null) {
        showMissingFieldError();
      } else {
        response = db.postReport(username, subject, body, date, email, pending);
        response.then((response) {
          print(response.response);
        });
        showSuccess();
        resetPageFunction();
        return response;
      }
    } on Exception catch (exception) {
      print(exception);
      return response;
    }
    return response;
  }

  //this function resets the page when form is submitted
  resetPageFunction() {
    setState(() {
      _bodyController.text = "";
      _subjectController.text = "";
      enableButton();
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String username = widget.user.displayName;
    DateTime now = new DateTime.now();
    var dateFormatter = new DateFormat.yMMMMEEEEd('en_us');
    String todaysDate = dateFormatter.format(now);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: size.width,
        height: size.height / 1.5,
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
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text("Enter your report here",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _subjectController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Subject of concern...",
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _bodyController,
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Type Report here...",
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: (_image != null)
                                ? Image.file(_image)
                                : Container(),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: isEnabled ? () => imageFunction() : null,
                        color: waterBlueColour,
                        child: Text(
                          imageSelectBtnText,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        disabledColor: Colors.grey[700],
                        disabledTextColor: Colors.grey,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await postUserReport(
                              username,
                              _subjectController.text,
                              _bodyController.text,
                              todaysDate,
                              widget.user.email,
                              "false",
                            );
                            // await sendEmail();
                            resetPageFunction();
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
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

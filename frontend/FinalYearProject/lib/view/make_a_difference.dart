import 'package:FinalYearProject/CustomDialog/CustomDialog.dart';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/models/VolunteerModel.dart';
import 'package:FinalYearProject/models/getNumVolunteersModel.dart';
import 'package:FinalYearProject/services/getNumLocalVolunteers.dart';
import 'package:FinalYearProject/services/postVolunteerToDb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class MakeADifferencePage extends StatefulWidget {
  final FirebaseUser user;

  const MakeADifferencePage(
    this.user,
  );

  @override
  _MakeADifferencePageState createState() => _MakeADifferencePageState();
}

class _MakeADifferencePageState extends State<MakeADifferencePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //variables for current location
  Position _currentPosition;
  String _currentCity;

  // Function which shows the success Message
  void showSuccess() {
    showDialog(
        context: (context),
        child: CustomDialog(
            title: "Thank you!",
            description:
                "You have successfully signed up to Volunteer! The team at AquaSafe thank you!",
            buttonText: "Close",
            alertImage: "assets/drawer_logo.png",
            buttonColor: waterBlueColour));
  }

  //function that converts the users lat and long into the corresponding city
  _getCityFromUserCoordinates() async {
    try {
      Position pos = await GeolocatorPlatform.instance.getCurrentPosition();

      final coordinates = new Coordinates(pos.latitude, pos.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      String city = addresses.first.subAdminArea;

      setState(() {
        _currentCity = city;
      });
    } catch (e) {
      print(e);
    } finally {
      updateNumVolunteers();
    }
  }

  //function that handles the post request to add the user to the volunteer list in db
  Future<VolunteerModel> postVolunteer(
      String username, String location, String date, String email) async {
    ReportVolunteerToDb db = new ReportVolunteerToDb();
    Future<VolunteerModel> response;
    try {
      response = db.postVolunteer(username, location, date, email);
      response.then((response) {
        print(response.status);
      });
      showSuccess();

      return response;
    } on Exception catch (exception) {
      print(exception);
      return response;
    }
  }

  Future<GetNumVolunteersModel> getNumVolunteers(String location) async {
    GetNumVolunteers db = new GetNumVolunteers();
    Future<GetNumVolunteersModel> response;
    try {
      response = db.fetchNumVolunteers(location.toString());
      return response;
    } on Exception catch (exception) {
      print(exception);
      return response;
    }
  }

  //string to hold the number of volunteers
  String numVolunteers;

  @override
  void initState() {
    super.initState();
    //call the function to get the users city name upon page load
    _getCityFromUserCoordinates();
  }

  //updates the number of volunteers to be shown at bottom of page
  void updateNumVolunteers() async {
    String volNum = "0";
    await getNumVolunteers(_currentCity.toString()).then((result) {
      volNum = result.volunteersInArea.toString();
    });

    setState(() {
      numVolunteers = volNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    //variables to store the width and height of screen
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    //create the date time object
    DateTime now = new DateTime.now();
    var dateFormatter = new DateFormat.yMMMMEEEEd('en_us');
    String todaysDate = dateFormatter.format(now);
    var username = widget.user.displayName;
    String volNum = numVolunteers;

    //return the page
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 5.0,
        title: Text("Make a difference ",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: waterBlueColour,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight / 10,
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
                    "AquaSafe Volunteer Program",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Image.asset('assets/volunteers.png'),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Container(
                width: screenWidth,
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
                          "Do you want to live in a world with less water pollution?\nIf so why not sign up to our AquaSafe cleanup program. The process is simple, all you need to do is click the signup button and we will handle the rest. You will be kept up to date with any cleanup projects happening within your area, local water pollution news and much more!",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () async {
                  await postVolunteer(
                      username, _currentCity, todaysDate, widget.user.email);
                },
                color: waterBlueColour,
                child: Text(
                  "Sign Up!",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            volNum != null && _currentCity != null
                ? Column(
                    children: [
                      Text(
                        "There are already $volNum volunteer(s) in your area...",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        "Current location: $_currentCity",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  )
                : CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}

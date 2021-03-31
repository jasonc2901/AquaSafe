import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 5.0,
            title: Text("Privacy",
                style: TextStyle(color: Colors.white, fontSize: 30)),
            backgroundColor: waterBlueColour,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                height: size.height / 5,
                width: size.width,
                decoration: BoxDecoration(
                  color: waterBlueColour,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
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
                      "AquaSafe Privacy Policy",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "At AquaSafe we take our users privacy very seriously. The following link describes our policies and procedures on the collection, use and disclosure of your information.",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/gdpr.png",
                height: screenHeight / 6,
                width: screenWidth / 2,
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () {
                  print('oressed');
                  String url =
                      'https://www.privacypolicies.com/live/e1b96afc-0ab4-4f36-840d-f50cc64db792';

                  launchURL(url);
                },
                color: waterBlueColour,
                child: Text("View Policy"),
              )
            ],
          ),
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: true, enableDomStorage: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}

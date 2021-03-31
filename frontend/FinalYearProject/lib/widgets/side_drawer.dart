import 'package:FinalYearProject/CustomDialog/logOutDialog.dart';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/FAQ.dart';
import 'package:FinalYearProject/view/bug_report_page.dart';
import 'package:FinalYearProject/view/make_a_difference.dart';
import 'package:FinalYearProject/view/onboarding_page.dart';
import 'package:FinalYearProject/view/privacy_policy.dart';
import 'package:FinalYearProject/view/user_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideDrawer extends StatefulWidget {
  final FirebaseUser user;
  const SideDrawer({Key key, this.user}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/drawer_logo.png"),
          ),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.photoUrl),
                radius: 30,
              ),
              trailing: Text(
                widget.user.displayName,
                style: TextStyle(fontSize: 25),
              ),
            ),
          )),
          SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: Icon(FlutterIcons.water_mco),
              title: Text(
                'AquaSafe',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnboardingPage(
                              user: widget.user,
                            )));
              },
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.nature_rounded),
              title: Text(
                'Make a difference',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MakeADifferencePage(widget.user)));
              },
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.info_rounded),
              title: Text(
                'FAQ',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FAQPage()));
              },
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.bug_report_rounded),
              title: Text(
                'Report a bug!',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportBug(widget.user)));
              },
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text(
                'Account details',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserAccountDetailsPage(
                              user: widget.user,
                            )));
              },
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.info_rounded),
              title: Text(
                'Data privacy policy',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicy()));
              },
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Sign out',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    child: LogOutDialog(
                        title: "Warning",
                        description: "Are you sure you want to Sign Out?",
                        buttonText: "Logout",
                        alertImage: "assets/warning.png",
                        buttonColor: Colors.amber));
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

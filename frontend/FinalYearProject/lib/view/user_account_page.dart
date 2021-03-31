import 'package:FinalYearProject/widgets/user_account_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class UserAccountDetailsPage extends StatefulWidget {
  final FirebaseUser user;
  UserAccountDetailsPage({Key key, this.user}) : super(key: key);

  @override
  _UserAccountDetailsPageState createState() => _UserAccountDetailsPageState();
}

class _UserAccountDetailsPageState extends State<UserAccountDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 5.0,
        title: Text("User Account",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: waterBlueColour,
      ),
      backgroundColor: waterBlueColour,
      body: ListView(
        children: [
          UserAccountWidget(user: widget.user),
        ],
      ),
    );
  }
}

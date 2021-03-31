import 'dart:io';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/route_page.dart';
import 'package:FinalYearProject/widgets/user_account_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final FirebaseUser user;

  const UserPage(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 5.0,
        toolbarHeight: 100.0,
        title: Text("Account Information",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: waterBlueColour,
      ),
      body: ListView(
        children: [
          SizedBox(height: 50.0),
          UserAccountWidget(user: user),
        ],
      ),
    );
  }
}

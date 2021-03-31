import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/home_page.dart';
import 'package:FinalYearProject/view/map_page.dart';
import 'package:FinalYearProject/view/report_page.dart';
import 'package:FinalYearProject/view/tools_page.dart';
import 'package:FinalYearProject/view/trends_page.dart';
import 'package:FinalYearProject/view/user_account_page.dart';
import 'package:FinalYearProject/widgets/side_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoutePage extends StatefulWidget {
  final FirebaseUser user;

  const RoutePage(
    this.user,
  );

  @override
  _ShowRoutePageState createState() => _ShowRoutePageState();
}

class _ShowRoutePageState extends State<RoutePage> {
  int _currentIndex = 0;
  String _title = "News";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      new HomePage(),
      new MapPage(widget.user),
      new ReportPage(widget.user),
      new TrendsPage(widget.user),
      new ToolsPage(widget.user),
    ];

    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          drawer: SideDrawer(
            user: widget.user,
          ),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 5.0,
            title: Text(_title,
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
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey[100],
            iconSize: 10,
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: new Image.asset("assets/news-icon.png"),
                  title: new Text("News")),
              BottomNavigationBarItem(
                  icon: new Image.asset("assets/map-icon.png"),
                  title: new Text("Map")),
              BottomNavigationBarItem(
                  icon: new Image.asset("assets/report-icon.png"),
                  title: new Text("Report")),
              BottomNavigationBarItem(
                  icon: new Image.asset("assets/trends-icon.png"),
                  title: new Text("Trends")),
              BottomNavigationBarItem(
                  icon: new Image.asset("assets/tools-icon.png"),
                  title: new Text("Tools"))
            ],
          ),
          backgroundColor: Colors.white,
          body: _children[_currentIndex],
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        _title = "News";
      } else if (_currentIndex == 1) {
        _title = "Pollution Tracker";
      } else if (_currentIndex == 2) {
        _title = "Reporting Hub";
      } else if (_currentIndex == 3) {
        _title = "Water Quality Data";
      } else if (_currentIndex == 4) {
        _title = "Useful Tools";
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

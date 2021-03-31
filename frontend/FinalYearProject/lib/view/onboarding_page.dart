import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/home_page.dart';
import 'package:FinalYearProject/view/route_page.dart';
import 'package:FinalYearProject/widgets/onboarding_content_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  final FirebaseUser user;
  OnboardingPage({Key key, this.user}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<Map<dynamic, dynamic>> screenData = [
      {
        "text":
            "Hello ${widget.user.displayName}. Welcome to AquaSafe, Let’s get started!",
        "image": "assets/drawer_logo.png",
        "height": screenHeight / 2.8,
        "width": screenWidth / 2
      },
      {
        "text":
            "We help our users keep up to date with water pollution news, check out our news page for some great articles!",
        "image": "assets/news.png",
        "height": screenHeight / 4.2,
        "width": screenWidth / 2
      },
      {
        "text":
            "We provide you access to data for every water body within Northern Ireland/Republic of Ireland. Just head over to the map page to check it out!",
        "image": "assets/rivers.png",
        "height": screenHeight / 4.2,
        "width": screenWidth / 2
      },
      {
        "text":
            "Noticed something when out for a walk that you think needs immediate attention? Why not use our report system to alert the council!",
        "image": "assets/dog-walking.png",
        "height": screenHeight / 4.2,
        "width": screenWidth / 1.2
      },
      {
        "text":
            "Do you require additional information regarding water pollution data? Check out the tools page to gain a better understanding!",
        "image": "assets/onboarding_tools.png",
        "height": screenHeight / 4.2,
        "width": screenWidth / 2
      },
    ];
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentSlide = value;
                      });
                    },
                    itemCount: screenData.length,
                    itemBuilder: (context, index) => OnboardingContentWidget(
                          image: screenData[index]["image"],
                          text: screenData[index]['text'],
                          width: screenData[index]['width'],
                          height: screenData[index]['height'],
                        )),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        screenData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: FlatButton(
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: waterBlueColour,
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RoutePage(widget.user)));
                        },
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 8,
      width: currentSlide == index ? 30 : 9,
      decoration: BoxDecoration(
        color: currentSlide == index ? waterBlueColour : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

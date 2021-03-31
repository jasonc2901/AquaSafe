import 'package:FinalYearProject/constants.dart';
import 'package:flutter/material.dart';

class OnboardingContentWidget extends StatelessWidget {
  const OnboardingContentWidget({
    Key key,
    this.text,
    this.image,
    this.height,
    this.width,
    recognizer,
  }) : super(key: key);

  final String text, image;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
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
          child: Center(
            child: Text(
              "AquaSafe",
              style: TextStyle(
                fontSize: 56,
                color: Colors.white,
                fontWeight: FontWeight.w400,
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
            text,
            style: TextStyle(
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
          image,
          height: height,
          width: width,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../constants.dart';

class QValueWidget extends StatelessWidget {
  const QValueWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Q Values Explained",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: waterBlueColour,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 4,
                    color: Colors.grey.withOpacity(0.7),
                    offset: Offset(0, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset('assets/QValueNew.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

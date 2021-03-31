import 'package:FinalYearProject/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EPANewsArticleWidget extends StatefulWidget {
  final String title;
  final String imgUrl;
  final String date;
  final String siteLink;

  EPANewsArticleWidget(
      {Key key,
      @required this.title,
      @required this.imgUrl,
      @required this.date,
      @required this.siteLink})
      : super(key: key);

  @override
  _EPANewsArticleWidget createState() => _EPANewsArticleWidget();
}

class _EPANewsArticleWidget extends State<EPANewsArticleWidget> {
  String author;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width / 3,
                height: size.width / 3,
                child: Image.network(
                  "${widget.imgUrl}",
                ),
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: size.width / 2,
                    child: Text(
                      "${widget.title}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.width / 8.5,
                  left: size.width / 35,
                  child: Container(
                    width: size.width / 2,
                    child: Text(
                      widget.date,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: size.width / 10, top: size.height / 5),
                    child: RaisedButton(
                      color: waterBlueColour,
                      child: Text(
                        "View Article",
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                      onPressed: () {
                        launchURL(widget.siteLink);
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceWebView: true, enableDomStorage: true, enableJavaScript: true);
  } else {
    throw 'Could not launch $url';
  }
}

import 'package:FinalYearProject/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RiverInformationPage extends StatefulWidget {
  final river;

  RiverInformationPage({Key key, this.river}) : super(key: key);

  @override
  RiverInformationPageState createState() => RiverInformationPageState();
}

class RiverInformationPageState extends State<RiverInformationPage> {
  List<dynamic> additionalInfo;
  String swimmingSuitable = 'Suitable';
  String fishingSuitable = 'Suitable';
  String activitiesSuitable = 'Suitable';

  @override
  void initState() {
    additionalInfo =
        additionalInfoExtraction(widget.river.additionalInformation);
    setSuitableTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pageSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 5.0,
          title: Text("${widget.river.name} info",
              style: TextStyle(color: Colors.white, fontSize: 25)),
          backgroundColor: waterBlueColour,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: pageSize.height / 3.5,
              width: pageSize.width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                child: Image.network(
                  widget.river.imageUrl,
                  width: pageSize.width,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${widget.river.name}",
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: pageSize.width,
                      height: 50,
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
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(FontAwesomeIcons.ruler),
                            Text(
                              "${widget.river.length}",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            SizedBox(width: pageSize.width / 20),
                            Icon(FontAwesomeIcons.mapMarkedAlt),
                            Text(
                              "${widget.river.location}",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            SizedBox(width: pageSize.width / 20),
                            Icon(Icons.warning_amber_rounded),
                            Text(
                              "${widget.river.pollutionStatus}",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: pageSize.width,
                height: pageSize.height / 5.8,
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Activities",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 50,
                                child: Image.asset("assets/swimming.png"),
                              ),
                              Text(
                                swimmingSuitable,
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                        Container(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 50,
                                child: Image.asset("assets/fishing.png"),
                              ),
                              Text(
                                fishingSuitable,
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                        Container(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 50,
                                child: Image.asset("assets/activities.png"),
                              ),
                              Text(
                                activitiesSuitable,
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                        Container(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: pageSize.width,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Additional Information",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          getInfo(additionalInfo),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                width: pageSize.width,
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
                child: ExpandablePanel(
                  header: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      widget.river.name + " description",
                      style: TextStyle(fontSize: 16),
                    )),
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.river.description,
                      softWrap: true,
                    ),
                  ),
                  tapHeaderToExpand: true,
                  hasIcon: true,
                ),
              ),
            ),
          ],
        )));
  }

  void setSuitableTags() {
    var status = widget.river.pollutionStatus;

    //if status is poor
    if (status.toString().contains("Poor") ||
        status.toString().contains("Bad") ||
        status.toString().contains("PEP")) {
      setState(() {
        swimmingSuitable = "Not Suitable";
        fishingSuitable = "Not Suitable";
        activitiesSuitable = "Not Suitable";
      });
    }
    //if status is moderate
    else if (status.toString().contains("Moderate")) {
      setState(() {
        swimmingSuitable = "Take Caution";
        fishingSuitable = "Suitable";
        activitiesSuitable = "Take Caution";
      });
    }
  }
}

List<dynamic> additionalInfoExtraction(List<dynamic> info) {
  var obj = info[0];
  List<dynamic> entries = new List<dynamic>();
  for (var entry in obj.entries) {
    String entryString = entry.key + ": " + entry.value;
    entries.add(entryString);
  }

  return entries;
}

Widget getInfo(List<dynamic> strings) {
  return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: strings
          .map((item) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  item,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ))
          .toList());
}

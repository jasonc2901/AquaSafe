import 'dart:async';
import 'dart:convert';
import 'package:FinalYearProject/models/RiverModel.dart';
import 'package:FinalYearProject/view/river_info_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import '../constants.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker_updates.dart';

class NearbyRiversWidget extends StatefulWidget {
  List<dynamic> nearby;
  List<Rivers> allRivers;
  final Completer<GoogleMapController> controller;
  final ScrollController scrollController;
  double distanceRangeMessage;
  final double currentLat;
  final double currentLng;
  final double searchLat;
  final double searchLng;
  final BitmapDescriptor highWaterIcon;
  final BitmapDescriptor goodWaterIcon;
  final BitmapDescriptor moderateWaterIcon;
  final BitmapDescriptor poorWaterIcon;
  final BitmapDescriptor badWaterIcon;
  final GoogleMapsController googleMapsController;

  NearbyRiversWidget({
    Key key,
    this.nearby,
    this.allRivers,
    this.scrollController,
    this.distanceRangeMessage,
    this.currentLat,
    this.currentLng,
    this.searchLat,
    this.searchLng,
    this.googleMapsController,
    this.moderateWaterIcon,
    this.controller,
    this.highWaterIcon,
    this.goodWaterIcon,
    this.poorWaterIcon,
    this.badWaterIcon,
  }) : super(key: key);

  @override
  _NearbyRiversWidgetState createState() => _NearbyRiversWidgetState();
}

class _NearbyRiversWidgetState extends State<NearbyRiversWidget> {
  bool niRiversSelected = false;
  bool roiRiversSelected = false;
  bool highRiversSelected = false;
  bool goodRiversSelected = false;
  bool moderateRiversSelected = false;
  bool poorRiversSelected = false;
  bool badRiversSelected = false;
  List<Marker> originalMarkers;

  @override
  void initState() {
    super.initState();
    originalMarkers = widget.googleMapsController.markers.toList();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.nearby.length > 0)
        ? ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Showing results within ${widget.distanceRangeMessage.floor()} miles."),
                    FlatButton(
                      onPressed: () {
                        _showFilterPopUp();
                      },
                      child: Text(
                        "Filter search",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              ...widget.nearby.map((river) {
                return Card(
                  child: ListTile(
                    title: Text(river.name),
                    subtitle: Text("Length: ${river.length}"),
                    trailing: IconButton(
                      icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                      tooltip: "View on map",
                      onPressed: () {
                        //animate camera to chosen river
                        double lat = double.tryParse(river.lAT);
                        double lon = double.tryParse(river.lON);
                        _animateCamera(lat, lon);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RiverInformationPage(river: river)));
                    },
                  ),
                );
              }).toList()
            ],
          )
        : Column(
            children: [
              Container(
                child: Text("No Nearby rivers for current location"),
              ),
              SizedBox(height: 20),
              FlatButton(
                onPressed: () {
                  _showFilterPopUp();
                },
                color: waterBlueColour,
                child: Text(
                  "Filter search",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          );
  }

  //handles the filter popup dialog
  void _showFilterPopUp() {
    slideDialog.showSlideDialog(
      context: context,
      child: Expanded(
        child: StatefulBuilder(
          builder: (context, state) => SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Text(
                      "Apply search filters",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Adjust the search distance",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Slider(
                                  value: widget.distanceRangeMessage,
                                  min: 0,
                                  max: 100,
                                  divisions: 100,
                                  label: widget.distanceRangeMessage
                                      .round()
                                      .toString(),
                                  activeColor: waterBlueColour,
                                  onChanged: (double value) {
                                    state(() {
                                      setState(() {
                                        //update the value of the slider
                                        widget.distanceRangeMessage = value;

                                        //if user has searched use that location
                                        //else use device location
                                        if (widget.searchLat != null &&
                                            widget.searchLng != null) {
                                          widget.nearby = _riverDistCalc(
                                              widget.allRivers,
                                              widget.searchLat,
                                              widget.searchLng,
                                              widget.distanceRangeMessage);
                                        } else {
                                          widget.nearby = _riverDistCalc(
                                              widget.allRivers,
                                              widget.currentLat,
                                              widget.currentLng,
                                              widget.distanceRangeMessage);
                                        }
                                      });
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("0 miles"),
                                        Text("100 miles"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                    "Currently: ${widget.distanceRangeMessage.floor()} miles."),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: CheckboxListTile(
                          value: niRiversSelected,
                          onChanged: (bool selectedVal) {
                            niRiversSelected = selectedVal;
                            state(() {
                              setState(() {
                                //reset checkboxes
                                highRiversSelected = false;
                                goodRiversSelected = false;
                                moderateRiversSelected = false;
                                poorRiversSelected = false;
                                badRiversSelected = false;

                                if (niRiversSelected == true) {
                                  //first ensure ROI checkbox isnt selected
                                  roiRiversSelected = false;

                                  //filter the rivers to show only NI
                                  filterNiRivers(widget.allRivers);
                                } else {
                                  //if we do not have this selected show all rivers
                                  filterAllRivers(widget.allRivers);
                                }
                              });
                            });
                          },
                          title: Text("NI Rivers Only"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: CheckboxListTile(
                          value: roiRiversSelected,
                          onChanged: (bool selectedVal) {
                            roiRiversSelected = selectedVal;
                            state(() {
                              setState(() {
                                //reset check boxes
                                highRiversSelected = false;
                                goodRiversSelected = false;
                                moderateRiversSelected = false;
                                poorRiversSelected = false;
                                badRiversSelected = false;

                                if (roiRiversSelected == true) {
                                  //first ensure NI checkbox isnt selected
                                  niRiversSelected = false;

                                  //show only ROI rivers on map
                                  filterROIRivers(widget.allRivers);
                                } else {
                                  //show all rivers on map
                                  filterAllRivers(widget.allRivers);
                                }
                              });
                            });
                          },
                          title: Text("ROI Rivers Only"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Checkbox(
                                    value: highRiversSelected,
                                    onChanged: (bool selectedVal) {
                                      highRiversSelected = selectedVal;
                                      state(() {
                                        if (highRiversSelected == true) {
                                          filterHighOnly();
                                        } else {
                                          //untick all choices
                                          roiRiversSelected = false;
                                          niRiversSelected = false;
                                          widget.googleMapsController
                                              .clearMarkers();
                                          widget.googleMapsController
                                              .addMarkers(originalMarkers);
                                        }
                                      });
                                    },
                                  ),
                                  Text("High")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      value: goodRiversSelected,
                                      onChanged: (bool selectedVal) {
                                        goodRiversSelected = selectedVal;
                                        state(() {
                                          if (goodRiversSelected == true) {
                                            filterGoodOnly();
                                          } else {
                                            //untick all choices
                                            roiRiversSelected = false;
                                            niRiversSelected = false;
                                            widget.googleMapsController
                                                .clearMarkers();
                                            widget.googleMapsController
                                                .addMarkers(originalMarkers);
                                          }
                                        });
                                      }),
                                  Text("Good")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      value: moderateRiversSelected,
                                      onChanged: (bool selectedVal) {
                                        moderateRiversSelected = selectedVal;
                                        state(() {
                                          if (moderateRiversSelected == true) {
                                            filterModerateOnly();
                                          } else {
                                            //untick all choices
                                            roiRiversSelected = false;
                                            niRiversSelected = false;
                                            widget.googleMapsController
                                                .clearMarkers();
                                            widget.googleMapsController
                                                .addMarkers(originalMarkers);
                                          }
                                        });
                                      }),
                                  Text("Moderate")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      value: poorRiversSelected,
                                      onChanged: (bool selectedVal) {
                                        poorRiversSelected = selectedVal;
                                        state(() {
                                          if (poorRiversSelected == true) {
                                            filterPoorOnly();
                                          } else {
                                            //untick all choices
                                            roiRiversSelected = false;
                                            niRiversSelected = false;
                                            widget.googleMapsController
                                                .clearMarkers();
                                            widget.googleMapsController
                                                .addMarkers(originalMarkers);
                                          }
                                        });
                                      }),
                                  Text("Poor")
                                ],
                              ),
                              Column(
                                children: [
                                  Checkbox(
                                      value: badRiversSelected,
                                      onChanged: (bool selectedVal) {
                                        badRiversSelected = selectedVal;
                                        state(() {
                                          if (badRiversSelected == true) {
                                            filterBadOnly();
                                          } else {
                                            //untick all choices
                                            roiRiversSelected = false;
                                            niRiversSelected = false;
                                            widget.googleMapsController
                                                .clearMarkers();
                                            widget.googleMapsController
                                                .addMarkers(originalMarkers);
                                          }
                                        });
                                      }),
                                  Text("Bad")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: waterBlueColour,
      backgroundColor: Colors.white,
    );
  }

  //function that handles clean river selection
  filterHighOnly() {
    List<Marker> highMarkers = new List<Marker>();
    List<Marker> markers = widget.googleMapsController.markers.toList();
    for (int i = 0; i < markers.length; i++) {
      List<dynamic> iconJsonList = markers[i].icon.toJson();

      if (iconJsonList[1].toString().contains('high_droplet')) {
        highMarkers.add(markers[i]);
      }
    }

    //update the markers
    widget.googleMapsController.clearMarkers();
    widget.googleMapsController.addMarkers(highMarkers);
  }

  //function that handles clean river selection
  filterGoodOnly() {
    List<Marker> goodMarkers = new List<Marker>();
    List<Marker> markers = widget.googleMapsController.markers.toList();
    for (int i = 0; i < markers.length; i++) {
      List<dynamic> iconJsonList = markers[i].icon.toJson();

      if (iconJsonList[1].toString().contains('good_droplet')) {
        goodMarkers.add(markers[i]);
      }
    }

    //update the markers
    widget.googleMapsController.clearMarkers();
    widget.googleMapsController.addMarkers(goodMarkers);
  }

  //function that handles moderate river selection
  filterModerateOnly() {
    List<Marker> moderateMarkers = new List<Marker>();
    List<Marker> markers = widget.googleMapsController.markers.toList();
    for (int i = 0; i < markers.length; i++) {
      List<dynamic> iconJsonList = markers[i].icon.toJson();

      if (iconJsonList[1].toString().contains('moderate_droplet')) {
        moderateMarkers.add(markers[i]);
      }
    }

    //update the markers
    widget.googleMapsController.clearMarkers();
    widget.googleMapsController.addMarkers(moderateMarkers);
  }

  //function that handles dirty river selection
  filterPoorOnly() {
    List<Marker> poorMarkers = new List<Marker>();
    List<Marker> markers = widget.googleMapsController.markers.toList();
    for (int i = 0; i < markers.length; i++) {
      List<dynamic> iconJsonList = markers[i].icon.toJson();

      if (iconJsonList[1].toString().contains('poor_droplet')) {
        poorMarkers.add(markers[i]);
      }
    }

    //update the markers
    widget.googleMapsController.clearMarkers();
    widget.googleMapsController.addMarkers(poorMarkers);
  }

  filterBadOnly() {
    List<Marker> badMarkers = new List<Marker>();
    List<Marker> markers = widget.googleMapsController.markers.toList();
    for (int i = 0; i < markers.length; i++) {
      List<dynamic> iconJsonList = markers[i].icon.toJson();

      if (iconJsonList[1].toString().contains('bad_droplet')) {
        badMarkers.add(markers[i]);
      }
    }

    //update the markers
    widget.googleMapsController.clearMarkers();
    widget.googleMapsController.addMarkers(badMarkers);
  }

  //function that handles NI river selection
  filterNiRivers(List<dynamic> rivers) {
    List<dynamic> filteredRivers = new List<dynamic>();

    if (rivers != null) {
      for (int i = 0; i < rivers.length; i++) {
        if (rivers[i].location == 'NI') {
          filteredRivers.add(rivers[i]);
        }
      }
    }

    //update the markers on the map
    widget.googleMapsController.clearMarkers();
    widget.googleMapsController
        .addMarkers(updateMarkers(filteredRivers).toList());
  }

  //function that handles roi river selection
  filterROIRivers(List<dynamic> rivers) {
    List<dynamic> filteredRivers = new List<dynamic>();

    if (rivers != null) {
      for (int i = 0; i < rivers.length; i++) {
        if (rivers[i].location == 'Ireland') {
          filteredRivers.add(rivers[i]);
        }
      }
    }

    //update the markers on the map
    widget.googleMapsController.clearMarkers();
    widget.googleMapsController
        .addMarkers(updateMarkers(filteredRivers).toList());
  }

  //function that handles all river selection
  filterAllRivers(List<dynamic> rivers) {
    List<dynamic> filteredRivers = new List<dynamic>();

    if (rivers != null) {
      for (int i = 0; i < rivers.length; i++) {
        if (rivers[i].location != null) {
          filteredRivers.add(rivers[i]);
        }
      }
    }

    //update the markers on the map
    widget.googleMapsController.clearMarkers();
    widget.googleMapsController
        .addMarkers(updateMarkers(filteredRivers).toList());
  }

  //function that handles updating map markers
  Set<Marker> updateMarkers(List<dynamic> riverList) {
    Set<Marker> _newMarkers = {};
    for (int i = 0; i < riverList.length; i++) {
      //variables that store lat, long and status of current index river
      double riverLat = double.tryParse(riverList[i].lAT);
      double riverLng = double.tryParse(riverList[i].lON);
      String pollutionStatus = riverList[i].pollutionStatus;

      //if river has valid data
      if (riverLng != null && riverLat != null) {
        //if river pollution is ... change icon
        if (pollutionStatus.contains("Poor") ||
            pollutionStatus.contains("Low")) {
          _newMarkers.add(Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(riverLat, riverLng),
            infoWindow: InfoWindow(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RiverInformationPage(river: riverList[i]),
                  ),
                );
              },
              title: riverList[i].name,
              snippet: riverList[i].length,
            ),
            icon: widget.poorWaterIcon,
          ));
        } else if (pollutionStatus.contains("Moderate") ||
            pollutionStatus.contains("Medium") ||
            pollutionStatus.contains("MEP")) {
          _newMarkers.add(Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(riverLat, riverLng),
            infoWindow: InfoWindow(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RiverInformationPage(river: riverList[i]),
                  ),
                );
              },
              title: riverList[i].name,
              snippet: riverList[i].length,
            ),
            icon: widget.moderateWaterIcon,
          ));
        } else if (pollutionStatus.contains("High")) {
          _newMarkers.add(Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(riverLat, riverLng),
            infoWindow: InfoWindow(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RiverInformationPage(river: riverList[i]),
                  ),
                );
              },
              title: riverList[i].name,
              snippet: riverList[i].length,
            ),
            icon: widget.highWaterIcon,
          ));
        } else if (pollutionStatus.contains("Good")) {
          _newMarkers.add(Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(riverLat, riverLng),
            infoWindow: InfoWindow(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RiverInformationPage(river: riverList[i]),
                  ),
                );
              },
              title: riverList[i].name,
              snippet: riverList[i].length,
            ),
            icon: widget.goodWaterIcon,
          ));
        } else if (pollutionStatus.contains("Bad")) {
          _newMarkers.add(Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(riverLat, riverLng),
            infoWindow: InfoWindow(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RiverInformationPage(river: riverList[i]),
                  ),
                );
              },
              title: riverList[i].name,
              snippet: riverList[i].length,
            ),
            icon: widget.badWaterIcon,
          ));
        }
      }
    }
    return _newMarkers;
  }

  _animateCamera(double _lat, double _lng) async {
    //move the camera back to the top of the screen
    widget.scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );

    final controller = await widget.controller.future;
    final camerapos = CameraPosition(target: LatLng(_lat, _lng), zoom: 10);
    controller.animateCamera(CameraUpdate.newCameraPosition(camerapos));
  }

  double _distanceCalc(
      double startLat, double startLong, double endLat, double endLong) {
    var dist = Geolocator.distanceBetween(startLat, startLong, endLat, endLong);
    double conversion = 0.00062137;
    var miles = dist * conversion;

    return miles;
  }

  _riverDistCalc(List<dynamic> rivers, double currentLat, double currentLng,
      double distance) {
    List<dynamic> nearbyRivers = new List<dynamic>();
    if (rivers != null) {
      for (int i = 0; i < rivers.length; i++) {
        double riverLat = double.tryParse(rivers[i].lAT);
        double riverLng = double.tryParse(rivers[i].lON);

        if (riverLng != null &&
            riverLat != null &&
            currentLat != null &&
            currentLng != null) {
          var distBetween =
              _distanceCalc(currentLat, currentLng, riverLat, riverLng);

          if (distBetween < distance) {
            nearbyRivers.add(rivers[i]);
          }
        }
      }
    }

    return nearbyRivers;
  }
}

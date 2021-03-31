import 'dart:async';
import 'package:FinalYearProject/models/RiverModel.dart';
import 'package:FinalYearProject/view/river_info_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RiverListWidget extends StatefulWidget {
  final List<Rivers> rivers;
  final Completer<GoogleMapController> controller;
  RiverListWidget({Key key, @required this.rivers, this.controller})
      : super(key: key);

  @override
  _RiverListWidgetState createState() => _RiverListWidgetState();
}

class _RiverListWidgetState extends State<RiverListWidget> {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: ListView.builder(
          itemCount: (widget.rivers != null) ? widget.rivers.length : 0,
          itemBuilder: (context, i) {
            return Card(
              child: ListTile(
                title: Text(widget.rivers[i].name),
                subtitle: Text("Length: ${widget.rivers[i].length}"),
                trailing: IconButton(
                  icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                  tooltip: "View on map",
                  onPressed: () {
                    //animate camera to chosen river
                    double lat = double.tryParse(widget.rivers[i].lAT);
                    double lon = double.tryParse(widget.rivers[i].lON);
                    _animateCamera(lat, lon);
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RiverInformationPage(river: widget.rivers[i])));
                },
              ),
            );
          }),
    );
  }

  _animateCamera(double _lat, double _lng) async {
    final controller = await widget.controller.future;
    final camerapos = CameraPosition(target: LatLng(_lat, _lng), zoom: 10);
    controller.animateCamera(CameraUpdate.newCameraPosition(camerapos));
  }
}

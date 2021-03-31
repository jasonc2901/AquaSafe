import 'dart:async';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/models/RiverModel.dart';
import 'package:FinalYearProject/services/secrets.dart';
import 'package:FinalYearProject/view/river_info_page.dart';
import 'package:FinalYearProject/widgets/nearby_river_list_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

class MapPage extends StatefulWidget {
  final FirebaseUser user;

  const MapPage(
    this.user,
  );

  _MapPageState createState() => _MapPageState();
}

//extract the api key from the secrets.dart file
const google_maps_api = api_key;

GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: google_maps_api);

class _MapPageState extends State<MapPage> {
  double _mapHeight;
  double _lat;
  double _lng;
  double defaultSliderValue;
  bool isIOS;

  //the controller to scroll the page for us
  final ScrollController _scrollController = ScrollController();

  List<dynamic> nearby = new List<dynamic>();

  BitmapDescriptor highWaterIcon;
  BitmapDescriptor goodWaterIcon;
  BitmapDescriptor moderateWaterIcon;
  BitmapDescriptor poorWaterIcon;
  BitmapDescriptor badWaterIcon;

  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapsController controller;

  @override
  void initState() {
    super.initState();
    //need to use this to gain access to context outside of build function
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mapHeight = MediaQuery.of(context).size.height / 3;

      //set initial nearby rivers to current device location
      _initialNearby(context);

      isIOS = Theme.of(context).platform == TargetPlatform.iOS;
      //Sets up the custom map marker for clean rivers
      BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              isIOS != true
                  ? 'assets/map_icons/high_droplet.png'
                  : 'assets/map_icons/high_droplet_ios.png')
          .then((onValue) {
        highWaterIcon = onValue;
      });

      //Sets up the custom map marker for dirty rivers
      BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              isIOS != true
                  ? 'assets/map_icons/good_droplet.png'
                  : 'assets/map_icons/good_droplet_ios.png')
          .then((onValue) {
        goodWaterIcon = onValue;
      });

      //Sets up the custom map marker for moderate/medium rivers
      BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              isIOS != true
                  ? 'assets/map_icons/moderate_droplet.png'
                  : 'assets/map_icons/moderate_droplet_ios.png')
          .then((onValue) {
        moderateWaterIcon = onValue;
      });

      //Sets up the custom map marker for moderate/medium rivers
      BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              isIOS != true
                  ? 'assets/map_icons/poor_droplet.png'
                  : 'assets/map_icons/poor_droplet_ios.png')
          .then((onValue) {
        poorWaterIcon = onValue;
      });

      //Sets up the custom map marker for moderate/medium rivers
      BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              isIOS != true
                  ? 'assets/map_icons/bad_droplet.png'
                  : 'assets/map_icons/bad_droplet_ios.png')
          .then((onValue) {
        badWaterIcon = onValue;
      });
    });

    //initialise the initial value of the slider
    defaultSliderValue = 10;
  }

  @override
  Widget build(BuildContext context) {
    final _location = Provider.of<Position>(context);
    final _riversProvider = Provider.of<Future<RiverModel>>(context);
    double _mapWidth = MediaQuery.of(context).size.width;

    controller = GoogleMapsController(
      initialCameraPosition: CameraPosition(
          target: LatLng(_location.latitude, _location.longitude), zoom: 10),
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        setState(() {});
      },
    );

    return FutureProvider(
      create: (context) => _riversProvider,
      child: (_location != null && _riversProvider != null)
          ? Scaffold(
              resizeToAvoidBottomPadding: false,
              body: Consumer<RiverModel>(
                builder: (_, rivers, __) {
                  if (rivers != null) {
                    //loops through all river and creates marker
                    for (int i = 0; i < rivers.rivers.length; i++) {
                      //variables that store lat, long and status of current index river
                      double riverLat = double.tryParse(rivers.rivers[i].lAT);
                      double riverLng = double.tryParse(rivers.rivers[i].lON);
                      String pollutionStatus = rivers.rivers[i].pollutionStatus;

                      //if river has valid data
                      if (riverLng != null && riverLat != null) {
                        //if river pollution is ... change icon
                        if (pollutionStatus.contains("Poor") ||
                            pollutionStatus.contains("Low")) {
                          _markers.add(Marker(
                            markerId: MarkerId(i.toString()),
                            position: LatLng(riverLat, riverLng),
                            infoWindow: InfoWindow(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RiverInformationPage(
                                        river: rivers.rivers[i]),
                                  ),
                                );
                              },
                              title: rivers.rivers[i].name,
                              snippet: rivers.rivers[i].length,
                            ),
                            icon: poorWaterIcon,
                          ));
                        } else if (pollutionStatus.contains("Moderate") ||
                            pollutionStatus.contains("Medium") ||
                            pollutionStatus.contains("MEP")) {
                          _markers.add(Marker(
                            markerId: MarkerId(i.toString()),
                            position: LatLng(riverLat, riverLng),
                            infoWindow: InfoWindow(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RiverInformationPage(
                                        river: rivers.rivers[i]),
                                  ),
                                );
                              },
                              title: rivers.rivers[i].name,
                              snippet: rivers.rivers[i].length,
                            ),
                            icon: moderateWaterIcon,
                          ));
                        } else if (pollutionStatus.contains("High")) {
                          _markers.add(Marker(
                            markerId: MarkerId(i.toString()),
                            position: LatLng(riverLat, riverLng),
                            infoWindow: InfoWindow(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RiverInformationPage(
                                        river: rivers.rivers[i]),
                                  ),
                                );
                              },
                              title: rivers.rivers[i].name,
                              snippet: rivers.rivers[i].length,
                            ),
                            icon: highWaterIcon,
                          ));
                        } else if (pollutionStatus.contains("Good")) {
                          _markers.add(Marker(
                            markerId: MarkerId(i.toString()),
                            position: LatLng(riverLat, riverLng),
                            infoWindow: InfoWindow(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RiverInformationPage(
                                        river: rivers.rivers[i]),
                                  ),
                                );
                              },
                              title: rivers.rivers[i].name,
                              snippet: rivers.rivers[i].length,
                            ),
                            icon: goodWaterIcon,
                          ));
                        } else if (pollutionStatus.contains("Bad")) {
                          _markers.add(Marker(
                            markerId: MarkerId(i.toString()),
                            position: LatLng(riverLat, riverLng),
                            infoWindow: InfoWindow(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RiverInformationPage(
                                        river: rivers.rivers[i]),
                                  ),
                                );
                              },
                              title: rivers.rivers[i].name,
                              snippet: rivers.rivers[i].length,
                            ),
                            icon: badWaterIcon,
                          ));
                        }
                      }
                    }

                    controller.addMarkers(_markers.toList());
                  }
                  //return the rendered page when rivers have loaded
                  return (rivers != null)
                      ? SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              (_mapHeight != null && _location != null)
                                  ? AnimatedContainer(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.fastOutSlowIn,
                                      height: _mapHeight,
                                      width: _mapWidth,
                                      child: GoogleMaps(
                                        controller: controller,
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 3.5, right: 3.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlatButton(
                                      onPressed: () {
                                        _maximiseMap(context);
                                      },
                                      child: Text("Expand map"),
                                      color: waterBlueColour,
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        _halfScreenMap(context);
                                      },
                                      child: Text("Minimise map"),
                                      color: waterBlueColour,
                                    ),
                                    FlatButton(
                                      onPressed: () async {
                                        await _showSearchScreen(rivers);
                                      },
                                      child: Text('Search Places'),
                                      color: waterBlueColour,
                                    ),
                                  ],
                                ),
                              ),
                              NearbyRiversWidget(
                                nearby: nearby,
                                allRivers: rivers.rivers,
                                controller: _controller,
                                scrollController: _scrollController,
                                distanceRangeMessage: defaultSliderValue,
                                currentLat: _location.latitude,
                                currentLng: _location.longitude,
                                searchLat: _lat,
                                searchLng: _lng,
                                googleMapsController: controller,
                                highWaterIcon: highWaterIcon,
                                goodWaterIcon: goodWaterIcon,
                                moderateWaterIcon: moderateWaterIcon,
                                poorWaterIcon: poorWaterIcon,
                                badWaterIcon: badWaterIcon,
                              )
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  _maximiseMap(BuildContext context) {
    setState(() {
      _mapHeight = MediaQuery.of(context).size.height / 2;
    });
  }

  _halfScreenMap(BuildContext context) {
    setState(() {
      _mapHeight = MediaQuery.of(context).size.height / 3;
    });
  }

  _showSearchScreen(RiverModel rivers) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction place = await PlacesAutocomplete.show(
        context: context, apiKey: google_maps_api, mode: Mode.overlay);

    await _displayPrediction(place, rivers);
  }

  _initialNearby(BuildContext context) async {
    final _riversProvider =
        Provider.of<Future<RiverModel>>(context, listen: false);
    final _locationProvider = Provider.of<Position>(context, listen: false);

    await _riversProvider.then((value) => {
          setState(() {
            RiverModel model = RiverModel.fromJson(value.toJson());
            if (_locationProvider.latitude != null &&
                _locationProvider.longitude != null) {
              nearby = _riverDistCalc(model, _locationProvider.latitude,
                  _locationProvider.longitude, defaultSliderValue);
            }
          })
        });
  }

  _displayPrediction(Prediction place, RiverModel rivers) async {
    var placeId = place.placeId;

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(placeId);

    setState(() {
      _lat = detail.result.geometry.location.lat;
      _lng = detail.result.geometry.location.lng;
    });

    _animateCamera();

    setState(() {
      nearby = _riverDistCalc(rivers, _lat, _lng, defaultSliderValue);
    });
  }

  _animateCamera() async {
    final controller = await _controller.future;
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

  _riverDistCalc(RiverModel rivers, double currentLat, double currentLng,
      double distance) {
    List<dynamic> nearbyRivers = new List<dynamic>();
    if (rivers != null) {
      for (int i = 0; i < rivers.rivers.length; i++) {
        double riverLat = double.tryParse(rivers.rivers[i].lAT);
        double riverLng = double.tryParse(rivers.rivers[i].lON);

        if (riverLng != null &&
            riverLat != null &&
            currentLat != null &&
            currentLng != null) {
          var distBetween =
              _distanceCalc(currentLat, currentLng, riverLat, riverLng);

          if (distBetween < distance) {
            nearbyRivers.add(rivers.rivers[i]);
          }
        }
      }
    }

    return nearbyRivers;
  }

  @override
  void dispose() {
    super.dispose();
    nearby = null;
    _markers = null;
    _controller = null;
  }
}

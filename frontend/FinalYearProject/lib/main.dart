import 'package:FinalYearProject/models/NewsModel.dart';
import 'package:FinalYearProject/models/RiverModel.dart';
import 'package:FinalYearProject/repository/NewsRepository.dart';
import 'package:FinalYearProject/services/geolocator_service.dart';
import 'package:FinalYearProject/services/rivers_service.dart';
import 'package:FinalYearProject/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final riversService = new RiversService();
  final geolocatorService = new GeolocatorService();
  final newsService = new NewsRepository();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => geolocatorService.getlocation()),
        ProxyProvider<Position, Future<NewsModel>>(
          update: (context, position, news) {
            return (position != null) ? newsService.getNews() : null;
          },
        ),
        ProxyProvider<Position, Future<RiverModel>>(
          update: (context, position, rivers) {
            return (position != null) ? riversService.getRivers() : null;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Water Pollution App',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getlocation() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}

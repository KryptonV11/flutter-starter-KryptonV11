import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Геолокация отключена в настройках устройства');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw Exception('Разрешение на геолокацию отклонено');
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Разрешение навсегда запрещено. Включи в настройках приложения');
    }

    // ignore: deprecated_member_use
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}

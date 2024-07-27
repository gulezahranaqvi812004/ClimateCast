import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
class Location{
  late double longitude;
  late double latitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      latitude=position.latitude;
      longitude=position.longitude;

      // Handle the position (e.g., update the UI, save to a database, etc.)
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}
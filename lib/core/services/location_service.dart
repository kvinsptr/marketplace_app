import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationService._();

  /// Meminta izin lokasi
  static Future<bool> requestPermission() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();

    if (!enabled) return false;

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Mengambil posisi saat ini
  static Future<Position?> getCurrentLocation() async {
    final granted = await requestPermission();

    if (!granted) return null;

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Mengubah koordinat menjadi alamat
  static Future<String> getAddress(
      double lat,
      double lng,
      ) async {
    final place = await placemarkFromCoordinates(lat, lng);

    if (place.isEmpty) return "";

    final p = place.first;

    return "${p.street}, ${p.subLocality}, ${p.locality}";
  }

  /// Tracking realtime
  static Stream<Position> positionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    );
  }
}
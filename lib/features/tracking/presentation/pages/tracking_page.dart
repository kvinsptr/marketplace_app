import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GoogleMapController? _controller;

  StreamSubscription<Position>? _positionStream;

  Marker? _userMarker;

  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(-6.200000, 106.816666),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) return;

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    _positionStream =
        Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      final current = LatLng(
        position.latitude,
        position.longitude,
      );

      setState(() {
        _userMarker = Marker(
          markerId: const MarkerId("me"),
          position: current,
          infoWindow: const InfoWindow(
            title: "Lokasi Saya",
          ),
        );
      });

      _controller?.animateCamera(
        CameraUpdate.newLatLng(current),
      );
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Realtime Tracking"),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        mapToolbarEnabled: true,
        markers: {
          if (_userMarker != null) _userMarker!,
        },
        onMapCreated: (controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.my_location),
        onPressed: () async {
          final position =
              await Geolocator.getCurrentPosition();

          _controller?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  position.latitude,
                  position.longitude,
                ),
                zoom: 17,
              ),
            ),
          );
        },
      ),
    );
  }
}
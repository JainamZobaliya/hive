import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/services/geolocator_service.dart';
// import 'package:places_autocomplete/services/geolocator_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeoLocatorService();
  Position currentLocation;

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}

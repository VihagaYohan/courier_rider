import 'package:courier_rider/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  bool loading = false;
  String error = "";
  // LocationData? currentLocation;
  Position? currentLocation;

  bool get isLoading => loading;
  String get errorMessage => error;
  // LocationData? get locationData => currentLocation;
  Position? get locationData => currentLocation;

  void setLoading(bool value) {
    loading = value;
  }

  void setError(String value) {
    loading = false;
    error = value;
    notifyListeners();
  }

  void onSuccess() {
    loading = false;
    error = "";
    notifyListeners();
  }

  // get user current location
  fetchCurrentLocation() async {
    try {
      setLoading(true);
      // LocationData response = await Helper.getCurrentLocation();
      Position response = await Helper.getCurrentLocation();
      print('from service');
      print(response.latitude);
      print(response.longitude);
      /* if (response == null) {
        setError("Unable to fetch location");
      } else {
        onSuccess();
        currentLocation = response;
      } */
      onSuccess();
      currentLocation = response;
    } catch (e) {
      setError("Unable to fetch current location");
    }
    setLoading(false);
  }
}

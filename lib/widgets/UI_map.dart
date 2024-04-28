import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as GeoLocation;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// config
import 'package:courier_rider/config/keys.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class UIMap extends StatefulWidget {
  final double sourceLatitude;
  final double sourceLongitude;

  const UIMap(
      {super.key, required this.sourceLatitude, required this.sourceLongitude});

  @override
  State<UIMap> createState() => _UIMapState();
}

class _UIMapState extends State<UIMap> {
  final GeoLocation.Location locationController = GeoLocation.Location();
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.951985742426179, 79.91907061043204),
    zoom: 14.4746,
  );

  LocationData? currentLocationData;

  /* 
    kelaniya
    6.951985742426179, 79.91907061043204

    scope
    6.918019253978862, 79.85590288768323
   */

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => {initializeMap()});
  }

  Future<void> initializeMap() async {
    await fetchLocation();
  }

  Future<void> fetchLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await locationController.getLocation();
    setState(() {
      currentLocationData = locationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('lat : ${widget.sourceLatitude} lng: ${widget.sourceLongitude}');

    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.sourceLatitude, widget.sourceLongitude),
          /* LatLng(
              currentLocationData!.latitude as double,
              currentLocationData!.latitude
                  as double), */ // LatLng(widget.sourceLatitude, widget.sourceLongitude),
          zoom: 13),
      onMapCreated: (GoogleMapController _controller) {
        controller.complete(_controller);
      },
    );
  }

/*   @override
  Widget build(BuildContext context) {
    print('coordinates');
    print('lat : ${widget.sourceLatitude} lng: ${widget.sourceLongitude}');

    return GoogleMap(
      initialCameraPosition: const CameraPosition(
          // target: LatLng(widget.sourceLatitude, widget.sourceLongitude),
          target: LatLng(37.386, -122.08377),
          zoom: 13),
      mapType: MapType.terrain,
      markers: {
        Marker(
            markerId: const MarkerId("currentLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(widget.sourceLatitude, widget.sourceLongitude))
      },
    );
  } */
}

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

// keys
import 'package:courier_rider/config/keys.dart';

class UIMap extends StatefulWidget {
  final double sourceLatitude;
  final double sourceLongitude;
  final double destinationLatitude;
  final double destinationLongitude;

  const UIMap(
      {super.key,
      required this.sourceLatitude,
      required this.sourceLongitude,
      required this.destinationLatitude,
      required this.destinationLongitude});

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
  late Circle circle;
  late Marker marker;
  late Uint8List currentLocationIcon;
  final Map<String, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  late StreamSubscription locationSubscription;

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
    final coordinates = await fetchPolyLinePoints();
    generatePolyLineFromPoints(coordinates);
  }

  // fetch user current location
  Future<void> fetchLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    Uint8List imageData = await getMarker();

    /* serviceEnabled = await locationController.serviceEnabled();
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
    } */

    locationData = await locationController.getLocation();
    updateMarkerAndCircle(locationData, imageData);

    setState(() {
      currentLocationData = locationData;
    });

    /* if (locationSubscription != null) {
      locationSubscription.cancel();
    } */

    locationSubscription =
        locationController.onLocationChanged.listen((currentLocation) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        if (controller != null) {
          final GoogleMapController mapController = await controller.future;
          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(currentLocation.latitude as double,
                      currentLocation.longitude as double),
                  zoom: 18.00)));

          // updateMarkerAndCircle(locationData, imageData);
        }

/*         locationData = await locationController.getLocation();

        setState(() {
          currentLocationData = locationData;
        });

        updateMarkerAndCircle(locationData, imageData); */
      }
    });
  }

  @override
  void dispose() {
    if (locationSubscription != null) {
      locationSubscription.cancel();
    }
    super.dispose();
  }

  Future<List<LatLng>> fetchPolyLinePoints() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
        KEYS.googleAPI,
        PointLatLng(widget.sourceLatitude, widget.sourceLongitude),
        PointLatLng(widget.destinationLatitude, widget.destinationLongitude));

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');
    final polyline = Polyline(
        polylineId: id,
        color: AppColors.primary,
        points: polylineCoordinates,
        width: 4);

    setState(() => polylines[id] = polyline);
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load('assets/images/other/vehicle1.png');
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(
      GeoLocation.LocationData newLocationData, Uint8List imageData) {
    LatLng latLng = LatLng(newLocationData.latitude as double,
        newLocationData.longitude as double);
    setState(() {
      marker = Marker(
          markerId: const MarkerId("vehicle"),
          position: latLng,
          rotation: newLocationData.heading as double,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.sourceLatitude, widget.sourceLongitude),
          zoom: 14.4746),
      onMapCreated: (GoogleMapController mapController) {
        controller.complete(mapController);
      },
      markers: Set.of((marker != null)
          ? [
              marker,
              Marker(
                  markerId: const MarkerId("destinationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(
                      widget.destinationLatitude, widget.destinationLongitude))
            ]
          : []),
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}

import 'dart:async';
import 'dart:ui' as ui;

import 'package:courier_rider/utils/constants.dart';
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

  LocationData? currentLocationData;
  late Circle circle;
  late Marker marker;
  late Uint8List currentLocationIcon;
  final Map<String, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  late StreamSubscription locationSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeMap();
    });
  }

  Future<void> initializeMap() async {
    await fetchLocation();
    final coordinates = await fetchPolyLinePoints();
    generatePolyLineFromPoints(coordinates);
  }

  // fetch current location and move google map camera to current location
  Future<void> fetchLocation() async {
    LocationData locationData;
    Uint8List imageData = await getMarker();

    // get user current location
    locationData = await locationController.getLocation();
    updateMarkerAndCircle(locationData, imageData);

    // update state
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
        final GoogleMapController mapController = await controller.future;
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(currentLocation.latitude as double,
                    currentLocation.longitude as double),
                zoom: 18.00)));

        updateMarkerAndCircle(currentLocation, imageData);
        // updateMarkerAndCircle(locationData, imageData);

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
    return Stack(
      children: <Widget>[
        // google map
        GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.sourceLatitude, widget.sourceLongitude),
              zoom: 14),
          onMapCreated: (GoogleMapController mapController) {
            controller.complete(mapController);
          },
          markers: Set.of((marker != null)
              ? [
                  marker,
                  Marker(
                      markerId: const MarkerId("destinationLocation"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(widget.destinationLatitude,
                          widget.destinationLongitude)),
                  Marker(
                      markerId: const MarkerId("curentLocation"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(034),
                      position:
                          LatLng(widget.sourceLatitude, widget.sourceLongitude))
                ]
              : []),
          polylines: Set<Polyline>.of(polylines.values),
        ),

        // duration and distance
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Constants.smallSpace,
              horizontal: Constants.mediumSpace),
          child: Positioned(
              child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: DeviceUtils.isDarkmode(context) == true
                    ? AppColors.dark
                    : AppColors.white,
                borderRadius: BorderRadius.circular(Constants.borderRadius),
                border: Border.all(color: AppColors.primary, width: 3)),
            child: const Center(
              child: UITextView(
                text: "Minutes remaining",
              ),
            ),
          )),
        ),
      ],
    );
  }
}

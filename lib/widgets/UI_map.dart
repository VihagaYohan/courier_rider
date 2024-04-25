import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as GeoLocation;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

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

  @override
  void initState() {
    super.initState();
  }

  // get user current location

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.sourceLatitude, widget.sourceLongitude),
          zoom: 13),
      mapType: MapType.terrain,
      markers: {
        Marker(
            markerId: const MarkerId("currentLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(widget.sourceLatitude, widget.sourceLongitude))
      },
    );
  }
}

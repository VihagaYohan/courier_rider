import 'dart:async';

import 'package:courier_rider/config/keys.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as GeoLocation;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:provider/provider.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// models
import 'package:courier_rider/models/models.dart';
import 'package:location/location.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

// providers
import 'package:courier_rider/provider/providers.dart';

class OrderTracking extends StatefulWidget {
  final OrderResponse orderDetail;

  const OrderTracking({super.key, required this.orderDetail});

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  final GeoLocation.Location locationController = GeoLocation.Location();
  // final LiveLocation.Location location = LiveLocation.Location();

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 13,
  );
  static const mountainView = LatLng(37.3861, -122.0839);
  LatLng? currentPosition =
      const LatLng(37.43296265331129, -122.08832357078792);
  Map<PolylineId, Polyline> polylines = {};

  static const CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false)
        .fetchCurrentLocation();
    /*  WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeMap();
    }); */
  }

/*   Future<void> initializeMap() async {
    await fetchLocation();
    ;
    final coordinates = await fetchPolylinePoints();
    generatePolyLineFromPoints(coordinates);
  }

  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      KEYS.googleAPI,
      PointLatLng(kGooglePlex.target.latitude, kGooglePlex.target.longitude),
      PointLatLng(mountainView.latitude, mountainView.longitude),
    );

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint(result.errorMessage);
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
      width: 5,
    );

    setState(() => polylines[id] = polyline);
  }

  Future<void> fetchLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

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

    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        print('hello');
        print(
            'current lat ${currentPosition?.latitude} current lng ${currentPosition?.longitude}');
      }
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        if (locationProvider.isLoading == true) {
          return const UIProgressIndicator();
        } else if (locationProvider.isLoading == false &&
            locationProvider.errorMessage.isNotEmpty) {
          return Center(
            child: UITextView(text: locationProvider.errorMessage),
          );
        } else {
          return UIContainer(
            paddingLeft: 0,
            paddingRight: 0,
            paddingBottom: 0,
            showAppBar: true,
            appbar: const UIAppBar(title: "Order Tracking"),
            children: UIMap(
              orderId: widget.orderDetail.id,
              sourceLatitude: locationProvider.locationData!.latitude as double,
              sourceLongitude:
                  locationProvider.locationData!.longitude as double,
              destinationLatitude:
                  widget.orderDetail.receiverDetails.location.coordinates[0],
              destinationLongitude:
                  widget.orderDetail.receiverDetails.location.coordinates[1],
              name: '',
              address: '',
              mobileNumber: "",
              headerTitle: "",
            ),
          );
        }
      },
    );
    /* return UIContainer(
      paddingLeft: 0,
      paddingRight: 0,
      paddingBottom: 0,
      showAppBar: true,
      appbar: const UIAppBar(title: "Order Tracking"),
      isShowFab: false,
      Fab: FloatingActionButton.extended(
        onPressed: () {
          print('google maps');
        },
        label: const UITextView(text: 'To the lake'),
        icon: const Icon(Icons.directions_boat),
      ),
      children: UIMap(
        sourceLatitude: sourceLatitude,
        sourceLongitude: sourceLongitude,
        destinationLatitude: widget.orderDetail.receiverDetails.location.coordinates[0],
        destinationLongitude: widget.orderDetail.receiverDetails.location.coordinates[1]),
       children: GoogleMap(
        initialCameraPosition: kGooglePlex,
        mapType: MapType.terrain,
        markers: {
          Marker(
              markerId: const MarkerId('currentLocation'),
              icon: BitmapDescriptor.defaultMarker,
              position: currentPosition!),
          /*    Marker(
              markerId: const MarkerId('sourceLocation'),
              icon: BitmapDescriptor.defaultMarker,
              position: kGooglePlex.target),
          const Marker(
              markerId: MarkerId("destination"),
              icon: BitmapDescriptor.defaultMarker,
              position: mountainView) */
        },
        polylines: Set<Polyline>.of(polylines.values),
        onMapCreated: (GoogleMapController mapController) {
          controller.complete(mapController);
        },
      ),
    ); */
  }
}

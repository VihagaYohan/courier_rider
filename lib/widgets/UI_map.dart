import 'dart:async';
import 'dart:ui' as ui;

import 'package:courier_rider/models/OrderTrackingRequest.dart';
import 'package:courier_rider/screens/order/order_tracking.dart';
import 'package:courier_rider/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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

// service
import 'package:courier_rider/services/order_service.dart';

// models
import 'package:courier_rider/models/models.dart';

class UIMap extends StatefulWidget {
  final String orderId;
  final double sourceLatitude;
  final double sourceLongitude;
  final double destinationLatitude;
  final double destinationLongitude;
  final String name;
  final String address;
  final String mobileNumber;

  const UIMap(
      {super.key,
      required this.orderId,
      required this.sourceLatitude,
      required this.sourceLongitude,
      required this.destinationLatitude,
      required this.destinationLongitude,
      required this.name,
      required this.address,
      required this.mobileNumber});

  @override
  State<UIMap> createState() => _UIMapState();
}

class _UIMapState extends State<UIMap> {
  final GeoLocation.Location locationController = GeoLocation.Location();
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  LocationData? currentLocationData;
  late Marker marker;
  final Map<String, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  late StreamSubscription locationSubscription;
  bool isLoaded = false;
  double distance = 0;

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
    setState(() {
      isLoaded = true;
    });
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

    locationSubscription =
        locationController.onLocationChanged.listen((currentLocation) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          currentLocationData = currentLocation;
        });
        updateMarkerAndCircle(currentLocationData!, imageData);
        calculateDistance();
        /* print(
            "current lat ${currentLocation.latitude}\ncurrent lng ${currentLocation.longitude}"); */
        updateDelivery(currentLocation.latitude as double,
            currentLocation.longitude as double);
      }
    });
  }

  @override
  void dispose() {
    locationSubscription.cancel();
    super.dispose();
  }

  // get routes from current location to destination
  Future<List<LatLng>> fetchPolyLinePoints() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
        KEYS.googleAPI,
        // PointLatLng(widget.sourceLatitude, widget.sourceLongitude),
        PointLatLng(currentLocationData?.latitude as double,
            currentLocationData?.longitude as double),
        PointLatLng(widget.destinationLatitude, widget.destinationLongitude));

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      return [];
    }
  }

  // generate polylines for map
  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates) async {
    print("4");
    const id = PolylineId('polyline');
    final polyline = Polyline(
        polylineId: id,
        color: AppColors.primary,
        points: polylineCoordinates,
        width: 4);

    setState(() => polylines[id] = polyline);
  }

  // create bitmap from asset file
  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load('assets/images/other/vehicle1.png');
    return byteData.buffer.asUint8List();
  }

  // create a marker using custom marker icon
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

  // calculate distance
  void calculateDistance() async {
    try {
      double distanceInMeters = Geolocator.distanceBetween(
          currentLocationData!.latitude!,
          currentLocationData!.longitude!,
          widget.destinationLatitude,
          widget.destinationLongitude);
      setState(() {
        distance = distanceInMeters;
      });
    } catch (e) {
      print(e);
    }
  }

  // update delivery
  void updateDelivery(double lat, double lng) async {
    try {
      OrderTrackingRequest payload = OrderTrackingRequest(
          orderId: widget.orderId, latitude: lat, longitude: lng);
      await OrderService.updateOrderTracking(payload);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Stack(
            children: <Widget>[
              // google map
              GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                    target:
                        LatLng(widget.sourceLatitude, widget.sourceLongitude),
                    zoom: 15),
                onMapCreated: (GoogleMapController mapController) {
                  controller.complete(mapController);
                },
                // ignore: unnecessary_null_comparison
                markers: Set.of((marker != null)
                    ? [
                        marker,
                        Marker(
                            markerId: const MarkerId("destinationLocation"),
                            icon: BitmapDescriptor.defaultMarker,
                            position: LatLng(widget.destinationLatitude,
                                widget.destinationLongitude),
                            infoWindow: const InfoWindow(title: "Destination")),
                        Marker(
                            markerId: const MarkerId("curentLocation"),
                            icon: BitmapDescriptor.defaultMarkerWithHue(034),
                            position: LatLng(
                                widget.sourceLatitude, widget.sourceLongitude),
                            infoWindow: const InfoWindow(
                                title: "Your current location"))
                      ]
                    : []),
                polylines: Set<Polyline>.of(polylines.values),
              ),

              // duration and distance
              Positioned(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.smallSpace,
                    horizontal: Constants.mediumSpace),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: DeviceUtils.isDarkmode(context) == true
                          ? AppColors.dark
                          : AppColors.white,
                      borderRadius:
                          BorderRadius.circular(Constants.borderRadius),
                      border: Border.all(color: AppColors.primary, width: 3)),
                  child: Center(
                    child: UITextView(
                      text:
                          "${distance.ceil() > 1000 ? distance.ceil() / 1000 : distance.ceil()} ${distance.ceil() > 1000 ? ' Km' : ' m'} remaining",
                    ),
                  ),
                ),
              )),

              // mark as complete
              Positioned(
                bottom: Constants.smallSpace,
                left: Constants.largeSpace * 2,
                right: Constants.largeSpace * 2,
                child: UIElevatedButton(
                    label: "Mark as completed", onPress: () {}),
              ),

              // customer (reciever / sender)
              Positioned(
                top: Constants.largeSpace * 4,
                right: Constants.smallSpace,
                child: UIFabButton(
                    child: const UIIcon(
                      iconData: Icons.person,
                      iconColor: AppColors.white,
                    ),
                    onClick: () {
                      DeviceUtils.showBottomSheet(
                          context,
                          DeviceUtils.getScreenHeight(context) / 2,
                          SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Constants.mediumSpace,
                                  horizontal: Constants.smallSpace),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  customerWidget("Customer name", widget.name),
                                  const UISpacer(
                                    space: Constants.mediumSpace,
                                  ),
                                  customerWidget("Address", widget.address),
                                  const UISpacer(space: Constants.mediumSpace),
                                  customerWidget(
                                      "Phone number",
                                      AppFormatter.formatPhoneNumber(
                                          widget.mobileNumber))
                                ],
                              ),
                            ),
                          ));
                    }),
              )
            ],
          )
        : const UIProgressIndicator();
  }

  // field
  Widget customerWidget(String key, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        UITextView(
          text: key,
          textAlign: TextAlign.left,
          textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 17,
              ),
        ),
        const UISpacer(
          space: Constants.smallSpace,
        ),
        UITextView(
          text: value,
          textStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 15, color: AppColors.primary),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}

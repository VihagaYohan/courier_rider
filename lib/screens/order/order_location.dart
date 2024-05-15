import 'dart:convert';

import 'package:courier_rider/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// model
import 'package:courier_rider/models/models.dart';

class OrderLocation extends StatefulWidget {
  final OrderResponse orderDetail;
  final String headerTitle;
  const OrderLocation(
      {super.key, required this.orderDetail, required this.headerTitle});

  @override
  State<OrderLocation> createState() => _OrderLocationState();
}

class _OrderLocationState extends State<OrderLocation> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false)
        .fetchCurrentLocation();
  }

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
            appbar: UIAppBar(title: widget.headerTitle),
            children: UIMap(
              orderId: widget.orderDetail.id,
              sourceLatitude: locationProvider.locationData!.latitude as double,
              sourceLongitude:
                  locationProvider.locationData!.longitude as double,
              destinationLatitude: widget.headerTitle == "Drop Location" ||
                      widget.headerTitle == "Order Tracking"
                  ? widget.orderDetail.receiverDetails.location.coordinates[1]
                  : widget.orderDetail.senderDetails.location.coordinates[1],
              destinationLongitude: widget.headerTitle == "Drop Location" ||
                      widget.headerTitle == "Order Tracking"
                  ? widget.orderDetail.receiverDetails.location.coordinates[0]
                  : widget.orderDetail.senderDetails.location.coordinates[0],
            ),
          );
        }
      },
    );
  }
}

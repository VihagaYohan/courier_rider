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

  // fetch current location
  getCurrentLocation() async {
    try {
      final provider = Provider.of<LocationProvider>(context);
      LocationData response = provider.fetchCurrentLocation();
      print(jsonEncode(response));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locatinProvider, child) {
        if (locatinProvider.isLoading == true) {
          return const UIProgressIndicator();
        } else if (locatinProvider.isLoading == false &&
            locatinProvider.errorMessage.isNotEmpty) {
          return Center(
            child: UITextView(text: locatinProvider.errorMessage),
          );
        } else {
          return UIContainer(
            paddingLeft: 0,
            paddingRight: 0,
            paddingBottom: 0,
            showAppBar: true,
            appbar: UIAppBar(title: widget.headerTitle),
            children: UIMap(
              sourceLatitude: locatinProvider.locationData!.latitude as double,
              sourceLongitude:
                  locatinProvider.locationData!.longitude as double,
            ),
          );
        }
      },
    );
  }
}

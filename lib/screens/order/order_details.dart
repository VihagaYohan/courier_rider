import 'dart:convert';

import 'package:courier_rider/screens/order/order_location.dart';
import 'package:courier_rider/screens/order/order_tracking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:socket_io_client/socket_io_client.dart' as IO;

// models
import 'package:courier_rider/models/models.dart';

// widget
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderDetail});
  final OrderResponse orderDetail;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int index = 0;
  late IO.Socket socket;
  /*  final channel = WebSocketChannel.connect(
    Uri.parse(''),
  ); */

  @override
  void initState() {
    super.initState();
    connect();
  }

  continueStep() {
    if (index < 2) {
      setState(() {
        index += 1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      index = value;
    });
  }

  void connect() {
    socket = IO.io(Constants.server_URL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    try {
      socket.connect();
      socket.onConnect((data) => {print('connected')});
      // send data to socket server
      // socket.emit('/test', 'hello, world');
      socket.on('message', (data) => print(data));
    } catch (e) {
      print(e);
    }
  }

  // generate button label and header title for order location page
  String getTitle() {
    return widget.orderDetail.status.name == Constants.readyForPickup
        ? "Pick-up Location"
        : widget.orderDetail.status.name == Constants.readyForDelivery
            ? 'Drop Location'
            : widget.orderDetail.status.name == Constants.orderPickedUp
                ? 'Drop Location'
                : 'Pick-up Location';
  }

  @override
  Widget build(BuildContext context) {
    return UIContainer(
        showAppBar: true,
        appbar: const UIAppBar(title: ""),
        children: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // tracking number
            UITextView(
              text: 'Tracking # - ${widget.orderDetail.trackingId}',
              textStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),

            const UISpacer(
              space: Constants.mediumSpace,
            ),

            // courier type, date and time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // courier type
                    UITextView(
                      text: "${widget.orderDetail.courierType.name} delievery",
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),

                    // status
                    UITextView(
                      text: "Type : ${widget.orderDetail.packageType.name}",
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),

                // date and time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    UITextView(
                      text: AppFormatter.formatDate(DateTime.parse(
                          widget.orderDetail.senderDetails.pickUpDate)),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    UITextView(
                      text: widget.orderDetail.senderDetails.pickUpTime,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),

            const UISpacer(
              space: Constants.mediumSpace,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // status label
                UITextView(
                  text: "Delivery status",
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),

                // delivery status
                UITextView(
                  text: widget.orderDetail.status.name,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.primary),
                )
              ],
            ),

            const UISpacer(
              space: Constants.mediumSpace,
            ),

            const UIHeader(
              title: "Order Details",
            ),

            // from and to address
            UILocation(
                from: widget.orderDetail.senderDetails.address,
                to: widget.orderDetail.receiverDetails.address),

            const UISpacer(
              space: Constants.mediumSpace,
            ),

            const UIHeader(title: "Cost"),
            // total cost
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const UITextView(text: "Estimated cost"),
                    UITextView(
                        text: Helper.currencyFormat(
                            widget.orderDetail.orderTotal))
                  ],
                )
              ],
            ),

            const UISpacer(
              space: Constants.mediumSpace,
            ),

            // view location
            UIElevatedButton(
              label: getTitle(),
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderLocation(
                              orderDetail: widget.orderDetail,
                              headerTitle: getTitle(),
                            )));
              },
              isPrimary: false,
              showSuffixIcon: true,
              suffixIcon: const UIIcon(
                iconData: Icons.map,
                iconColor: AppColors.white,
              ),
            ),

            const UISpacer(
              space: Constants.mediumSpace,
            ),

            // track order
            if (widget.orderDetail.status.name == Constants.readyForDelivery)
              UIElevatedButton(
                label: 'Start Delivery',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OrderTracking(orderDetail: widget.orderDetail)));
                },
                showSuffixIcon: true,
                suffixIcon: const UIIcon(
                  iconData: Icons.local_shipping,
                  iconColor: AppColors.white,
                ),
              )
          ],
        ));
  }
}

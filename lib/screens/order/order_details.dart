import 'dart:convert';

import 'package:courier_rider/provider/order_provider.dart';
import 'package:courier_rider/screens/order/order_location.dart';
import 'package:courier_rider/screens/order/order_tracking.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';

// models
import 'package:courier_rider/models/models.dart';

// widget
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

// models
import 'package:courier_rider/models/models.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderDetail});
  final OrderResponse orderDetail;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final orderForm = GlobalKey<FormState>();
  int index = 0;
  late IO.Socket socket;
  List<CourierStatus> courierStatuses = [];
  late CourierStatus selectedStatus;
  late String currentStatus = "";

  @override
  void initState() {
    super.initState();
    // Provider.of<OrderProvider>(context, listen: false).getCourierStatusTypes();
    OrderProvider provider = Provider.of<OrderProvider>(context, listen: false);
    provider.getCourierStatusTypes();
    connect();
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
    return widget.orderDetail.status.name == Constants.readyForPickup ||
            currentStatus == Constants.readyForPickup
        ? "Pick-up Location"
        : widget.orderDetail.status.name == Constants.readyForDelivery ||
                currentStatus == Constants.readyForDelivery
            ? 'Drop Location'
            : widget.orderDetail.status.name == Constants.orderPickedUp ||
                    currentStatus == Constants.orderPickedUp
                ? 'Drop Location'
                : 'Pick-up Location';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        if (orderProvider.isLoading == true) {
          return const UIProgressIndicator();
        } else if (orderProvider.isLoading == false &&
            orderProvider.errorMessage.isNotEmpty) {
          return Center(
              child: UITextView(
            text: orderProvider.errorMessage,
          ));
        } else {
          return UIContainer(
              showAppBar: true,
              appbar: const UIAppBar(title: ""),
              children: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: orderForm,
                    child: Column(
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
                                  text:
                                      "${widget.orderDetail.courierType.name} delievery",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),

                                // status
                                UITextView(
                                  text:
                                      "Type : ${widget.orderDetail.packageType.name}",
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
                                      widget.orderDetail.senderDetails
                                          .pickUpDate)),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                UITextView(
                                  text: widget
                                      .orderDetail.senderDetails.pickUpTime,
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

                        // delivery status
                        UIDropDown(
                          placeholderText: currentStatus.isNotEmpty
                              ? currentStatus
                              : widget.orderDetail.status.name,
                          optionList: orderProvider.statusList,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select a delivery status";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              CourierStatus? courierStatus =
                                  Helper.findCourierStatusById(
                                      value, orderProvider.statusList);

                              if (courierStatus != null) {
                                setState(() {
                                  selectedStatus = courierStatus;
                                });
                                OrderResponse orderPayload = OrderResponse(
                                    id: widget.orderDetail.id,
                                    trackingId: widget.orderDetail.trackingId,
                                    status: Status(
                                        id: courierStatus.id,
                                        name: courierStatus.name,
                                        createdAt: courierStatus.createdAt),
                                    courierType: widget.orderDetail.courierType,
                                    packageType: widget.orderDetail.packageType,
                                    packageSize: widget.orderDetail.packageSize,
                                    senderDetails:
                                        widget.orderDetail.senderDetails,
                                    receiverDetails:
                                        widget.orderDetail.receiverDetails,
                                    orderTotal: widget.orderDetail.orderTotal,
                                    paymentType: widget.orderDetail.paymentType,
                                    createdOn: widget.orderDetail.createdOn,
                                    rider: widget.orderDetail.rider);

                                // update order status
                                orderProvider
                                    .updateOrderStatus(orderPayload)
                                    .then((value) {
                                  setState(() {
                                    currentStatus = value;
                                  });
                                });
                              }
                            });
                          },
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
                        if (widget.orderDetail.status.name ==
                                Constants.readyForDelivery ||
                            widget.orderDetail.status.name ==
                                Constants.orderPickedUp)
                          UIElevatedButton(
                            label: 'Start Delivery',
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderTracking(
                                          orderDetail: widget.orderDetail)));
                            },
                            showSuffixIcon: true,
                            suffixIcon: const UIIcon(
                              iconData: Icons.local_shipping,
                              iconColor: AppColors.white,
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ));
        }
      },
    );
  }
}

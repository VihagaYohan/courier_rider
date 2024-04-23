import 'dart:convert';

import 'package:courier_rider/navigation/bottomNavigation.dart';
import 'package:courier_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// models
import 'package:courier_rider/models/models.dart';

// widget
import 'package:courier_rider/widgets/widgets.dart';

// providers
import 'package:courier_rider/provider/providers.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class CheckoutScreen extends StatefulWidget {
  final OrderRequest orderDetails;

  const CheckoutScreen({super.key, required this.orderDetails});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // handle create order
  void handleCreateOrder(OrderRequest payload, OrderProvider provider,
      BuildContext context) async {
    try {
      bool response = await provider.createOrder(payload);

      if (provider.errorMessage.isEmpty != true) {
        // show alert box
        DeviceUtils.showAlertDialog(
            context, "Error", provider.errorMessage, "Close", () {
          Navigator.of(context).pop();
        }, Icons.warning,
            iconSize: 30,
            iconColor: AppColors.white,
            iconContainerColor: AppColors.error);
      } else {
        if (response) {
          // navigate to home screen
          DeviceUtils.showAlertDialog(
              context,
              "Your coruier has been\nbooked successfully",
              "you can track your shipment with tracking Id",
              "OK", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AppBottomNavigation()));
          }, Icons.check, iconSize: 30);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);

    return UIContainer(
      showAppBar: true,
      appbar: const UIAppBar(title: "Checkout"),
      children: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: SizedBox(
            child: ListView(
              children: <Widget>[
                // Your order
                UITextView(
                  text: "Your order",
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),

                const UISpacer(
                  space: Constants.smallSpace,
                ),

                // location
                location(context, widget.orderDetails.senderDetails,
                    widget.orderDetails.receiverDetails),

                const UISpacer(
                  space: Constants.mediumSpace,
                ),

                // payment details title
                UITextView(
                  text: "Payment details",
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),

                const UISpacer(
                  space: Constants.mediumSpace,
                ),

                // courier fee
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    UITextView(
                      text: "Courier Fee",
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 14,
                              ),
                    ),
                    UITextView(
                      text: Helper.currencyFormat(
                          widget.orderDetails.orderTotal!),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    )
                  ],
                ),

                const UISpacer(
                  space: Constants.mediumSpace,
                ),

                // divider
                const UIDivider(height: 1),

                const UISpacer(
                  space: Constants.mediumSpace,
                ),

                // total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    UITextView(
                      text: "Total",
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    UITextView(
                      text: Helper.currencyFormat(
                          widget.orderDetails.orderTotal!),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
          )),
          UIElevatedButton(
              label: "Pay Now",
              onPress: () {
                handleCreateOrder(widget.orderDetails, provider, context);
              })
        ],
      ),
    );
  }

  Widget location(BuildContext context, SenderDetails senderDetails,
      ReceiverDetails? receiverDetails) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color dividerColor =
        brightness == Brightness.dark ? AppColors.white : AppColors.darkGrey;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        recentItemLocationRow(context, Icons.location_city,
            "From : ${senderDetails.name}", senderDetails.address),
        SizedBox(
          height: 50,
          child: VerticalDivider(
            thickness: 1.2,
            width: 10,
            color: dividerColor,
          ),
        ),
        recentItemLocationRow(context, Icons.location_pin,
            "To : ${receiverDetails?.name}", receiverDetails?.address ?? "")
      ],
    );
  }

  Widget recentItemLocationRow(
      BuildContext context, IconData icon, String title, String subTitle) {
    return Row(
      children: <Widget>[
        Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.primary)),
        const SizedBox(width: Constants.mediumSpace),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UITextView(
              text: title,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            UITextView(
              text: Helper.getCityName(subTitle),
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }
}

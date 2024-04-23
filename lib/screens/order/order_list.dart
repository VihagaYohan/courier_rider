import 'package:courier_rider/services/service.dart';
import 'package:courier_rider/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// models
import "package:courier_rider/models/models.dart";

// widget
import 'package:courier_rider/widgets/widgets.dart';

// providers
import 'package:courier_rider/provider/providers.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

// screen
import 'package:courier_rider/screens/screens.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        if (orderProvider.isLoading == true) {
          return const UIProgressIndicator();
        } else if (orderProvider.isLoading == false &&
            orderProvider.errorMessage.isNotEmpty) {
          return Center(child: UITextView(text: orderProvider.errorMessage));
        } else {
          return UIContainer(
              children: ListView.separated(
            itemCount: orderProvider.orderList.length,
            itemBuilder: (context, index) {
              return orderItem(context, orderProvider.orderList[index]);
            },
            separatorBuilder: (context, index) => const UISpacer(
              space: Constants.smallSpace,
            ),
          ));
        }
      },
    );
  }

  // order item
  Widget orderItem(BuildContext context, OrderResponse item) {
    Color containerColor = DeviceUtils.isDarkmode(context) == true
        ? AppColors.dark
        : AppColors.softGrey;
    Color borderColor = DeviceUtils.isDarkmode(context) == true
        ? AppColors.primary
        : AppColors.white;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailsScreen(
                      orderDetail: item,
                    )));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            vertical: Constants.smallSpace, horizontal: Constants.mediumSpace),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: containerColor,
            borderRadius: BorderRadius.circular(Constants.borderRadius)),
        child: Column(
          children: [
            // tracking number
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                UITextView(
                  text: "Tracking ID",
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14),
                ),
                UITextView(
                  text: item.trackingId,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14),
                )
              ],
            ),

            const UISpacer(
              space: Constants.mediumSpace,
            ),

            // date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                UITextView(
                  text: "Date",
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12),
                ),
                UITextView(
                  text: AppFormatter.formatDate(DateTime.parse(item.createdOn)),
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                      ),
                )
              ],
            ),

            const UISpacer(
              space: Constants.smallSpace,
            ),

            // status
            orderStatus(context, item.status.name),

            // delivery person
            if (item.riderName != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  UITextView(
                    text: "Deliver person",
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  UITextView(
                    text: item.riderName!,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 12),
                  )
                ],
              ),

            const UISpacer(
              space: Constants.smallSpace,
            ),

            // payment method
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                UITextView(
                  text: "Payment method",
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (item.paymentType.name == Constants.cash)
                      const UIIcon(
                        iconData: Icons.money_sharp,
                        size: 20,
                      )
                    else
                      const UIIcon(iconData: Icons.credit_card, size: 20),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: Constants.smallSpace),
                      child: UITextView(
                        text: item.paymentType.name,
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 12,
                                ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // order status
  Widget orderStatus(BuildContext context, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        UITextView(
          text: "Status",
          textStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
        ),
        UITextView(
          text: status,
          textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: status == Constants.orderPlaced
                  ? AppColors.primary
                  : status == Constants.orderPickedUp
                      ? AppColors.secondary
                      : status == Constants.processing
                          ? AppColors.warning
                          : status == Constants.atBranch
                              ? AppColors.info
                              : status == Constants.atStorage
                                  ? AppColors.warning
                                  : status == Constants.outForDelivery
                                      ? AppColors.success
                                      : status == Constants.delivered
                                          ? AppColors.primary
                                          : status == Constants.returnInProcess
                                              ? AppColors.secondary
                                              : AppColors.error),
        )
      ],
    );
  }
}

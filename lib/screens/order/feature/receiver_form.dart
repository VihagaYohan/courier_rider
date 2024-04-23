import 'dart:convert';
import 'package:courier_rider/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:courier_rider/navigation/bottomNavigation.dart';
import 'package:courier_rider/screens/home/home_screen.dart';
import 'package:courier_rider/utils/courier_service.dart';
import 'package:courier_rider/utils/utils.dart';
import 'package:courier_rider/widgets/widgets.dart';

// components
import 'package:courier_rider/widgets/widgets.dart';

// Getx state-mangement
import 'package:courier_rider/global_state/global_state.dart';
import 'package:get/instance_manager.dart';

// models
import 'package:courier_rider/models/models.dart';

// service
import 'package:courier_rider/services/service.dart';

// provider
import 'package:courier_rider/provider/order_provider.dart';

class ReceiverForm extends StatefulWidget {
  final OrderRequest orderDetails;

  const ReceiverForm({super.key, required this.orderDetails});

  @override
  State<ReceiverForm> createState() => _ReceiverFormState();
}

class _ReceiverFormState extends State<ReceiverForm> {
  final receiverForm = GlobalKey<FormState>();
  final GlobalState globalState = Get.put(GlobalState());

  @override
  Widget build(BuildContext context) {
    final TextEditingController receiverNameController =
        TextEditingController(text: 'John Wick');
    final TextEditingController receiverMobileController =
        TextEditingController(text: "22333332");
    final TextEditingController receiverAddressController =
        TextEditingController(
            text: 'No. 41/2, Bodhirukkarama Road, Galboralla, Kelaniya');
    final TextEditingController receiverNoteController =
        TextEditingController(text: 'Receiver notes');

    final provider = Provider.of<OrderProvider>(context);

    return provider.isLoading == true
        ? const UIProgressIndicator()
        : UIContainer(
            showAppBar: true,
            appbar: const UIAppBar(title: "Send Package"),
            children: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                    key: receiverForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const UIHeader(title: "Receiver Details"),
                        // receiver name
                        UITextField(
                          controller: receiverNameController,
                          labelText: "Enter name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter name";
                            }
                            return null;
                          },
                        ),

                        const UISpacer(),

                        // mobile number
                        UITextField(
                          controller: receiverMobileController,
                          labelText: "Enter mobile number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter mobile number";
                            }
                            return null;
                          },
                        ),

                        const UISpacer(),

                        // address
                        UITextField(
                          controller: receiverAddressController,
                          labelText: "Enter address",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter address";
                            }
                            return null;
                          },
                        ),

                        const UISpacer(),

                        // note
                        UITextField(
                          controller: receiverNoteController,
                          labelText: "Notes",
                          maxLines: null,
                          expands: false,
                        )
                      ],
                    )),
                UIElevatedButton(
                    label: 'Done',
                    onPress: () {
                      if (receiverForm.currentState!.validate()) {
                        ReceiverDetails receiverDetails = ReceiverDetails(
                            name: receiverNameController.text,
                            mobileNumber: receiverMobileController.text,
                            address: receiverAddressController.text,
                            receiverNote: receiverNoteController.text);

                        OrderRequest orderPayload = OrderRequest(
                            courierTypeId: widget.orderDetails.courierTypeId,
                            packageTypeId: widget.orderDetails.packageTypeId,
                            packageSize: widget.orderDetails.packageSize,
                            senderDetails: widget.orderDetails.senderDetails,
                            receiverDetails: receiverDetails,
                            orderTotal: widget.orderDetails.orderTotal,
                            paymentType: widget.orderDetails.paymentType);

                        // handleCreateOrder(orderPayload, provider, context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CheckoutScreen(orderDetails: orderPayload)));
                      }
                    })
              ],
            ),
          );
  }
}

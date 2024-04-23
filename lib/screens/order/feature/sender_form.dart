import 'dart:convert';
import 'dart:ffi';

import 'package:courier_rider/models/CourierType.dart';
import 'package:courier_rider/models/PackageType.dart';
import 'package:courier_rider/screens/order/feature/receiver_form.dart';
import 'package:courier_rider/services/helper_service.dart';
import 'package:courier_rider/utils/courier_service.dart';
import 'package:courier_rider/utils/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// widget
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';
import 'package:flutter/widgets.dart';

// models
import 'package:courier_rider/models/models.dart';

// Getx state-mangement
import 'package:courier_rider/global_state/global_state.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/instance_manager.dart';

class SenderForm extends StatefulWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController datePickerController = TextEditingController();
  final TextEditingController timePickerController = TextEditingController();
  final TextEditingController senderNotesController = TextEditingController();
  final TextEditingController shipmentTypeController = TextEditingController();
  int? selectedPacakgeType = 1;
  List<CourierType> courierTypes = [];
  List<PackageType> packageTypes = [];
  List<PaymentTypes> paymentTypes = [];
  String? shipmentType;
  String? packageType;
  String? paymentType;
  String? senderAddress;
  String? currentUserId;

  SenderForm({super.key, this.shipmentType});

  @override
  State<SenderForm> createState() => _SenderFormState();
}

class _SenderFormState extends State<SenderForm> {
  final senderForm = GlobalKey<FormState>();
  final GlobalState c = Get.put(GlobalState());

  @override
  void initState() {
    super.initState();
    fetchCourierTypes();
    fetchPackageTypes();
    fetchPaymentTypes();
    getUserInfo();

    // calculate total
    // getTotalCharge();
  }

  // fetch courier types / shipment types
  void fetchCourierTypes() async {
    try {
      var res = await HelperService.getShipmentTypes();
      setState(() {
        widget.courierTypes = res;
      });
    } catch (e) {
      print(e);
    }
  }

  // fetch all package types
  void fetchPackageTypes() async {
    try {
      var res = await HelperService.getPackageTypes();
      setState(() {
        widget.packageTypes = res;
      });
    } catch (e) {
      print(e);
    }
  }

  // fetch all payment types
  void fetchPaymentTypes() async {
    try {
      var res = await HelperService.getPaymentTypes();
      setState(() {
        widget.paymentTypes = res;
      });
    } catch (e) {
      print(e);
    }
  }

  // fetch data from shared preferences
  Future<UserInfo?> getUserInfo() async {
    try {
      final response = await Helper.getData<String>(Constants.user);
      print(response);
      if (response?.isEmpty == false) {
        Map<String, dynamic> jsonMap = json.decode(response.toString());
        UserInfo userInfo = UserInfo.fromJson(jsonMap);

        widget.emailController.text = userInfo.email;
        widget.nameController.text = userInfo.name;
        widget.phoneNumberController.text = userInfo.phoneNumber;
        setState(() {
          widget.senderAddress = userInfo.address;
          widget.currentUserId = userInfo.id;
        });
      }
    } catch (e) {
      print("Error at loading user details $e");
    }
  }

  // calculate total order amount
  getTotalCharge() async {
    try {
      double totalAmount = await CourierService.calculateCourierCharge(
          // "Express",
          // "documents",
          "small",
          "65df3456d1bb363d65c35968",
          "65df3495d1bb363d65c3596a");
      print('total $totalAmount');
      return totalAmount;
    } catch (e) {
      print(e);
    }
  }

  // handle navigation
  void handleNavigation(double amount) {
    SenderDetails senderDetails = SenderDetails(
        senderId: widget.currentUserId ?? "",
        name: widget.nameController.text,
        email: widget.emailController.text,
        pickUpDate: widget.datePickerController.text,
        pickUpTime: widget.timePickerController.text,
        mobileNumber: widget.phoneNumberController.text,
        address: widget.senderAddress ?? "",
        senderNotes: widget.senderNotesController.text);

    OrderRequest orderObj = OrderRequest(
        courierTypeId: widget.shipmentTypeController.text,
        packageTypeId: widget.packageType ?? "",
        packageSize: widget.selectedPacakgeType == 1
            ? 'small'
            : widget.selectedPacakgeType == 2
                ? 'medium'
                : 'large',
        senderDetails: senderDetails,
        orderTotal: amount,
        paymentType: widget.paymentType);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReceiverForm(orderDetails: orderObj)));
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    // package size list
    List<PackageSize> packageSize = [
      PackageSize(
          index: 1,
          icon: smallPackageIcon(
            context,
          ),
          text: "< 1 KG"),
      PackageSize(
          index: 2, icon: mediumPackageIcon(context), text: "3 KG - 10 KG"),
      PackageSize(index: 3, icon: largePackageIcon(context), text: "> 10 KG")
    ];

    return Form(
        key: senderForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const UIHeader(title: "Shipment Type"),
            // shipment type
            UIDropDown(
              placeholderText: 'Select type',
              optionList: widget.courierTypes,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select shipment type";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.shipmentType = value;
                  widget.shipmentTypeController.text = value;
                });
              },
            ),

            const UIHeader(
              title: "Sender Details",
            ),

            // sender name
            UITextField(
              controller: widget.nameController,
              labelText: "Enter name",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
            const UISpacer(),

            // phone number
            UITextField(
              controller: widget.phoneNumberController,
              labelText: "Enter mobile number",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter mobile number";
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            const UISpacer(),

            // email
            UITextField(
              controller: widget.emailController,
              labelText: "Email address",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email address";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const UISpacer(),

            // pick-up date
            UIDatePicker(
              controll: widget.datePickerController,
              labelText: "Pickup Date",
              onTap: () {
                print('on trapping');
              },
              showIcon: true,
              suffixIcon: Icon(Icons.calendar_month),
              suffixIconColor: brightness == Brightness.dark
                  ? AppColors.white
                  : AppColors.dark,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select pick-up date";
                }
                return null;
              },
            ),
            const UISpacer(),

            // pick-up time
            UITimePicker(
                controll: widget.timePickerController,
                labelText: "Pickup Time",
                onTap: () {
                  print('on tapping');
                },
                showIcon: true,
                suffixIcon: const Icon(Icons.timer_outlined),
                suffixIconColor: brightness == Brightness.dark
                    ? AppColors.white
                    : AppColors.dark,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select pick-up time";
                  }
                }),
            const UIHeader(title: "Package Size"),

            // package size
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                for (var item in packageSize) packageSizeType(context, item)
              ],
            ),
            const UIHeader(title: "Package Type"),

            // package type type
            UIDropDown(
              placeholderText: 'Select package type',
              optionList: widget.packageTypes,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select courier type";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.packageType = value;
                });
              },
            ),

            const UISpacer(),

            // payment type
            const UIHeader(title: "Payment type"),

            // payment type drop down
            UIDropDown(
              placeholderText: "Select a payment method",
              optionList: widget.paymentTypes,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a payment type";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.paymentType = value;
                });
              },
            ),

            const SizedBox(height: Constants.mediumSpace),

            // sender notes
            SizedBox(
              // height: 200,
              child: UITextField(
                controller: widget.senderNotesController,
                labelText: "Notes from sender",
                maxLines: null,
                expands: false,
              ),
            ),

            const SizedBox(height: Constants.mediumSpace),

            // next button
            UIElevatedButton(
                label: "Next",
                onPress: () async {
                  if (senderForm.currentState!.validate()) {
                    double totalAmount = await getTotalCharge();

                    DeviceUtils.showAlertDialog(
                        context,
                        "Estimated Cost",
                        "Courier estimated cost is $totalAmount\nDo you wish to proceed?",
                        "Yes", () {
                      handleNavigation(totalAmount);
                    }, Icons.info,
                        iconSize: 30,
                        iconContainerColor: AppColors.error,
                        iconColor: AppColors.white,
                        showCancelButton: true);
                  }
                })
          ],
        ));
  }

// package size item
  Widget packageSizeType(BuildContext context, PackageSize item) {
    bool isDarkmode = DeviceUtils.isDarkmode(context);
    double boxWidth = (DeviceUtils.getScreenWidth(context) -
            (Constants.mediumSpace * 2) -
            50) /
        3;
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.selectedPacakgeType = item.index;
        });
      },
      child: Container(
        width: boxWidth,
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: widget.selectedPacakgeType == item.index
                    ? AppColors.primary
                    : AppColors.grey),
            borderRadius: BorderRadius.circular(Constants.smallSpace),
            color: isDarkmode == true ? AppColors.dark : null),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              item.icon,
              const SizedBox(height: Constants.smallSpace / 2),
              UITextView(
                text: item.text,
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 12,
                    color: widget.selectedPacakgeType == item.index
                        ? AppColors.primary
                        : isDarkmode == true
                            ? AppColors.grey
                            : AppColors.dark),
              )
            ],
          ),
        ),
      ),
    );
  }

  // cube icon widget
  Widget packageSizeItemIcon(
    BuildContext context,
    int option,
  ) {
    bool isDarkmode = DeviceUtils.isDarkmode(context);
    Color iconColor = widget.selectedPacakgeType == option
        ? AppColors.primary
        : isDarkmode == true
            ? AppColors.grey
            : AppColors.dark;
    return UIIcon(iconData: CupertinoIcons.cube_box, iconColor: iconColor);
  }

  // small-icon
  Widget smallPackageIcon(BuildContext context) {
    int option = 1;
    return packageSizeItemIcon(context, option);
  }

  // medium-icon
  Widget mediumPackageIcon(BuildContext context) {
    int option = 2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        packageSizeItemIcon(context, 2),
        packageSizeItemIcon(context, 2)
      ],
    );
  }

  // large-icon
  Widget largePackageIcon(BuildContext context) {
    int option = 3;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        packageSizeItemIcon(context, 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            packageSizeItemIcon(context, 3),
            packageSizeItemIcon(context, 3)
          ],
        )
      ],
    );
  }
}

class PackageSize {
  final int index;
  final Widget icon;
  final String text;

  PackageSize({required this.index, required this.icon, required this.text});
}

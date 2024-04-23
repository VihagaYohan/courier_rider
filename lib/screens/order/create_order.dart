import 'package:courier_rider/utils/device_utility.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

// feature
import 'package:courier_rider/screens/order/feature/feature.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UIContainer(
        showAppBar: true,
        appbar: const UIAppBar(
          title: "Send Package",
        ),
        children: ListView(
          children: <Widget>[
            SenderForm(),
          ],
        ));
  }
}

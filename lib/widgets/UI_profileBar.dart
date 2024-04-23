import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'dart:convert';

// widgets
import './widgets.dart';

// utils
import '../utils/utils.dart';

// models
import 'package:courier_rider/models/models.dart';

class UIProfileBar extends StatefulWidget {
  UIProfileBar({super.key});
  String cityName = "";

  @override
  State<UIProfileBar> createState() => _UIProfileBarState();
}

class _UIProfileBarState extends State<UIProfileBar> {
  @override
  void initState() {
    super.initState();
    fetchUserLocation();
  }

  // fetch user profile
  fetchUserLocation() async {
    try {
      final response = await Helper.getData<String>(Constants.user);
      if (response?.isEmpty == false) {
        Map<String, dynamic> jsonMap = json.decode(response.toString());
        UserInfo userInfo = UserInfo.fromJson(jsonMap);
        String address = userInfo.address!;

        final userCity = Helper.getCityName(address);
        if (userCity.isEmpty == false) {
          setState(() {
            widget.cityName = userCity;
          });
        } else {
          setState(() {
            widget.cityName = "Sri, Lanka";
          });
        }
      }

      /* final response =  Helper.getCityName();
      if (response?.isEmpty == false) {
        setState(() {
          widget.cityName = response ?? "Sri, Lanka";
        });
        print(response);
      } else {
        setState(() {
          widget.cityName = "Sri, Lanka";
        });
      } */
    } catch (e) {
      print("Error at fetching location, $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // location pin icon & user current location
        Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary.withOpacity(0.15)),
              child: const UIIcon(iconData: Icons.pin_drop_outlined),
            ),
            Container(
              margin: const EdgeInsets.only(left: Constants.mediumSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const UITextView(text: "Your location"),
                  UITextView(
                    text: widget.cityName,
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        ),

        // profile image
        /* Container(
          width: 42,
          height: 40,
          decoration:
              BoxDecoration(border: Border.all(color: AppColors.primary)),
        ) */
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        )
      ],
    );
  }
}

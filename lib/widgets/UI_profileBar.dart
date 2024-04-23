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
  String name = "";

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
        String userName = userInfo.name!;

        if (userName.isEmpty == false) {
          setState(() {
            widget.name = userName;
          });
        } else {
          setState(() {
            widget.name = "";
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
    return
        // name
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const UITextView(text: "Hi!"),
        UITextView(
          text: widget.name,
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 18,
              ),
        )
      ],
    );
  }
}

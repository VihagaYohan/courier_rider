import 'dart:convert';

import 'package:courier_rider/models/SignInResponse.dart';
import 'package:courier_rider/screens/screens.dart';
import 'package:courier_rider/utils/colors.dart';
import 'package:courier_rider/utils/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// services
import 'package:courier_rider/services/service.dart';

// models
import 'package:courier_rider/models/models.dart';
import 'package:courier_rider/models/UserInfo.dart';

// utils
import 'package:courier_rider/utils/utils.dart';
import 'package:provider/provider.dart';

// providers
import 'package:courier_rider/provider/providers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController(text: 'vihagayohan94@gmail.com');

  final TextEditingController passwordController =
      TextEditingController(text: 'asdfasdf');

  final loginForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  // handle user sign-in
  handleAuthentication(
      SignIn payload, AuthProvider provider, BuildContext context) async {
    UserInfo? response = await provider.userSignIn(payload);
    if (provider.errorMessage.isEmpty != true) {
      // show alert box
      DeviceUtils.showAlertDialog(context, "Error",
          "${provider.errorMessage}\nPlease try again", "Close", () {
        () {
          Navigator.of(context).pop();
        };
      }, Icons.warning,
          iconSize: 30,
          iconColor: AppColors.white,
          iconContainerColor: AppColors.error);
    } else {
      if (response?.token.isEmpty != true) {
        // store data in shared preference
        await Helper.setData<String>(Constants.user, jsonEncode(response));
        // navigate to contact details page
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ContactDataScreen()));
      }
    }
  }

  // get items from shared prefrence
  getUserFromSharedPreference(String key) async {
    try {
      final response = await Helper.getData<String>(key);
      print(response);
    } catch (e) {
      print("Error at getting data ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return provider.isLoading == true
        ? const UIProgressIndicator()
        : UIContainer(
            children: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (provider.isLoading == true) const UIProgressIndicator(),

              const SizedBox(height: 50),

              // logo
              const Image(
                  image: Svg('assets/images/logos/app_logo_primary.svg'),
                  width: 90,
                  height: 90),
              const SizedBox(height: 20),

              // sub-title
              UITextView(
                text: "Let's get you login !",
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              // list view -> holds the login form widgets
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Form(
                      key: loginForm,
                      child: Column(
                        children: <Widget>[
                          // email field
                          UITextField(
                            controller: emailController,
                            labelText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter email";
                              }
                            },
                          ),
                          const UISpacer(
                            space: Constants.smallSpace,
                          ),

                          // password
                          UITextField(
                            controller: passwordController,
                            labelText: "Password",
                            obsecureText: true,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                            },
                          ),

                          // reset password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              UITextButton(
                                  onPress: () {},
                                  labelText: "Forgot password ?",
                                  textColor:
                                      DeviceUtils.isDarkmode(context) == false
                                          ? AppColors.primary
                                          : AppColors.white,
                                  buttonColor:
                                      DeviceUtils.isDarkmode(context) == true
                                          ? AppColors.dark
                                          : AppColors.white),
                            ],
                          ),

                          const UISpacer(
                            space: Constants.mediumSpace,
                          ),

                          UIElevatedButton(
                            label: "Login",
                            onPress: () {
                              if (loginForm.currentState!.validate()) {
                                handleAuthentication(
                                    SignIn(
                                        email: emailController.text,
                                        password: passwordController.text),
                                    provider,
                                    context);
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],

            // loadin
          ));
  }
}

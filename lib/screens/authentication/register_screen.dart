import 'dart:convert';

import 'package:courier_rider/models/UserRegister.dart';
import 'package:courier_rider/routes/routes.dart';
import 'package:courier_rider/screens/authentication/login_screen.dart';
import 'package:courier_rider/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// service
import 'package:courier_rider/services/service.dart';

// models
import 'package:courier_rider/models/models.dart';

// provider
import 'package:courier_rider/provider/providers.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController =
      TextEditingController(text: 'John Wick');
  final TextEditingController emailController =
      TextEditingController(text: 'johnwick@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'asdf');
  final TextEditingController phoneNumberController =
      TextEditingController(text: '0716995328');

  final registerForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  // handle user registration
  handleUserRegistration(
      UserRegister payload, AuthProvider provider, BuildContext context) async {
    UserInfo? response = await provider.userRegister(payload);

    if (provider.errorMessage.isEmpty != true) {
      // show alert box
      DeviceUtils.showAlertDialog(context, "Error",
          "${provider.errorMessage}\nPlease try again.", "Close", () {
        Navigator.of(context).pop();
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
              const SizedBox(height: 50),

              // logo
              const Image(
                  image: Svg('assets/images/logos/app_logo_primary.svg'),
                  width: 90,
                  height: 90),
              const SizedBox(height: 20),

              // sub-title
              UITextView(
                text: "Let's create an account !",
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
                      key: registerForm,
                      child: Column(
                        children: <Widget>[
                          const UISpacer(
                            space: Constants.mediumSpace,
                          ),

                          // name field
                          UITextField(
                            controller: nameController,
                            labelText: "Name",
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter name";
                              }
                            },
                          ),
                          const UISpacer(space: Constants.smallSpace),

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

                          const UISpacer(
                            space: Constants.smallSpace,
                          ),

                          // phone number field
                          UITextField(
                            controller: phoneNumberController,
                            labelText: "Phone number",
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter phone number";
                              }
                            },
                          ),

                          const UISpacer(
                            space: Constants.smallSpace,
                          ),

                          const UISpacer(
                            space: Constants.mediumSpace,
                          ),

                          UIElevatedButton(
                            label: "Register",
                            onPress: () {
                              if (registerForm.currentState!.validate()) {
                                handleUserRegistration(
                                    UserRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phoneNumber:
                                            phoneNumberController.text),
                                    provider,
                                    context);
                              }
                            },
                          ),

                          const UISpacer(space: Constants.mediumSpace),

                          const UITextView(text: 'or'),

                          const UISpacer(space: Constants.mediumSpace),

                          // register
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: RichText(
                                text: TextSpan(
                                    text: "Already have an account ?",
                                    style: TextStyle(
                                        color:
                                            DeviceUtils.isDarkmode(context) ==
                                                    true
                                                ? AppColors.white
                                                : AppColors.textPrimary),
                                    children: const <TextSpan>[
                                  TextSpan(text: " "),
                                  TextSpan(
                                      text: "Login",
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold)),
                                ])),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ));
  }
}

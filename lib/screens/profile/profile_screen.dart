import 'package:courier_rider/screens/screens.dart';
import 'package:courier_rider/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// model
import 'package:courier_rider/models/models.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

// providers
import 'package:courier_rider/provider/providers.dart';

// navigator
import 'package:courier_rider/routes/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).getCurrentUser();
  }

  // fetch profile data
  void handleUserLogout() async {
    try {
      Helper.deleteData(Constants.user);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (e) {
      print("Error at logging out");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        if (profileProvider.isLoading == true) {
          return const UIProgressIndicator();
        } else if (profileProvider.isLoading == false &&
            profileProvider.errorMessage.isNotEmpty) {
          return Center(
            child: UITextView(text: profileProvider.errorMessage),
          );
        } else {
          return UIContainer(
            isShowFab: true,
            Fab: UIFabButton(
              child: const UIIcon(
                iconData: Icons.exit_to_app,
                iconColor: AppColors.white,
              ),
              onClick: () {
                handleUserLogout();
              },
            ),
            children: ListView(
              children: <Widget>[
                const UISpacer(
                  space: Constants.largeSpace,
                ),

                // avatar
                UIAvatar(name: profileProvider.currentUser.name),
                const UISpacer(
                  space: Constants.mediumSpace,
                ),

                // name
                UITextView(
                  text: profileProvider.currentUser.name,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const UISpacer(
                  space: Constants.smallSpace,
                ),

                // email
                UITextView(
                    text: "Email : ${profileProvider.currentUser.email}"),

                const UISpacer(
                  space: Constants.smallSpace,
                ),

                // phone number
                UITextView(
                    text: "Tel : ${profileProvider.currentUser.phoneNumber}"),
              ],
            ),
          );
        }
      },
    );
  }
}

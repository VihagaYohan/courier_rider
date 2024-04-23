import 'package:courier_rider/screens/screens.dart';
import 'package:courier_rider/services/helper_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UIContainer(
        paddingTop: Constants.mediumSpace,
        children: ListView(
          children: <Widget>[
            UIProfileBar(),
            trackCard(context),
            recentDelivery(context),
            const SizedBox(height: Constants.mediumSpace),
            UITextView(
              text: "Our Services",
              textAlign: TextAlign.left,
              textStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: Constants.mediumSpace),
            servicesItem(context)
          ],
        ));
  }

  Widget trackCard(BuildContext context) {
    final TextEditingController trackingNumberController =
        TextEditingController();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: Constants.largeSpace),
      padding: const EdgeInsets.symmetric(vertical: Constants.mediumSpace / 2),
      decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Constants.smallSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UITextView(
              text: "Track your package",
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
            ),
            const SizedBox(height: 10),
            UITextView(
              text: "Please enter your tracking number",
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 12),
            ),

            const SizedBox(
              height: Constants.mediumSpace,
            ),
            // search tracking number field and search button
            SizedBox(width: double.infinity, child: searchField(context)),

            // recent delivery
          ],
        ),
      ),
    );
  }

  Widget searchField(BuildContext context) {
    final TextEditingController trackingNumberController =
        TextEditingController();

    return Row(
      children: <Widget>[
        Flexible(
            child: UITextField(
          controller: trackingNumberController,
          labelText: 'Tracking number',
          keyboardType: TextInputType.number,
          borderColor: AppColors.primary,
        )),
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(left: 50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary),
          child: IconButton(
              color: AppColors.white,
              onPressed: () {
                print('hello');
              },
              icon: const UIIcon(
                iconData: Icons.search,
                iconColor: AppColors.white,
              )),
        )
      ],
    );
  }

  Widget recentDelivery(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color containerColor =
        brightness == Brightness.dark ? AppColors.dark : AppColors.softGrey;
    Color borderColor =
        brightness == Brightness.dark ? AppColors.primary : AppColors.white;
    Color dividerColor =
        brightness == Brightness.dark ? AppColors.white : AppColors.darkGrey;

    return Column(
      children: <Widget>[
        // recent delivery title and view all text button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            UITextView(
              text: "Recent Delivery",
              textStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            UITextButton(
              onPress: () {},
              labelText: "View All",
              buttonColor: DeviceUtils.isDarkmode(context) == true
                  ? AppColors.dark
                  : AppColors.white,
            )
          ],
        ),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              vertical: Constants.largeSpace,
              horizontal: Constants.mediumSpace),
          decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(Constants.smallSpace),
              border: Border.all(color: borderColor)),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsets.only(right: Constants.mediumSpace),
                    decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: const UIIcon(
                      iconData: CupertinoIcons.cube_box,
                      size: 24,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UITextView(
                        text: "Macbook Air M2 (Space Gray)",
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      UITextView(
                        text: "Tracking ID: 374884",
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontWeight: FontWeight.w300, fontSize: 14),
                      )
                    ],
                  )
                ],
              ),

              const SizedBox(height: 10),
              // horizontal line
              Divider(
                color: dividerColor,
                thickness: 1,
              ),

              const SizedBox(height: 10),

              // recent location
              location(context)
            ],
          ),
        )
      ],
    );
  }

  // source and destination
  Widget location(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color dividerColor =
        brightness == Brightness.dark ? AppColors.white : AppColors.darkGrey;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        recentItemLocationRow(
            context, Icons.location_city, "From", "GenexT, Colombo"),
        SizedBox(
          height: 50,
          child: VerticalDivider(
            thickness: 1.2,
            width: 10,
            color: dividerColor,
          ),
        ),
        recentItemLocationRow(
            context, Icons.location_pin, "To", "1A, Waragoda Rd, Kelaniya")
      ],
    );
  }

  // recent item row
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
              text: subTitle,
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

  // services
  Widget servicesItem(BuildContext context) {
    double width = DeviceUtils.getScreenWidth(context) -
        40; // 40 is the default value for left and right padding in UIContainer widget
    double boxWidth = (width - 20) / 2;

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // navigate to create order screen
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CreateOrderScreen()));
            },
            child: Container(
              width: boxWidth,
              padding:
                  const EdgeInsets.symmetric(vertical: Constants.mediumSpace),
              decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(Constants.smallSpace)),
              child: const Center(
                child: Column(
                  children: [
                    UIIcon(
                      iconData: Icons.local_shipping,
                      iconColor: AppColors.primary,
                    ),
                    SizedBox(
                      height: Constants.mediumSpace,
                    ),
                    UITextView(text: "Courier")
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: boxWidth,
            padding:
                const EdgeInsets.symmetric(vertical: Constants.mediumSpace),
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Constants.smallSpace)),
            child: const Center(
              child: Column(
                children: [
                  UIIcon(
                    iconData: Icons.location_on,
                    iconColor: AppColors.primary,
                  ),
                  SizedBox(
                    height: Constants.mediumSpace,
                  ),
                  UITextView(text: "Tracking")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

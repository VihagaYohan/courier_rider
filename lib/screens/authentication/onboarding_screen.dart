import 'package:courier_rider/screens/authentication/login_screen.dart';
import 'package:courier_rider/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// models
import 'package:courier_rider/models/models.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Onboarding> onboardingItems = [
    Onboarding(
        index: 0,
        imageUrl: 'assets/images/svgs/onboarding_1.svg',
        title: 'Best package\ndelivery for you'),
    Onboarding(
        index: 1,
        imageUrl: 'assets/images/svgs/onboarding_2.svg',
        title: "Track your parcel from anywhere"),
    Onboarding(
        index: 2,
        imageUrl: 'assets/images/svgs/onboarding_3.svg',
        title: "Get your parcel safely on time")
  ];

  int currentIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return UIContainer(
        children: Stack(
      children: <Widget>[
        PageView.builder(
          controller: _pageController,
          itemCount: onboardingItems.length,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return pageItem(onboardingItems[index]);
          },
        ),
        footer(context)
      ],
    ));
  }

  // contains the title and button
  Positioned footer(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Column(
        children: [
          UITextView(
              text: onboardingItems[currentIndex].title,
              textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 60),
          UIElevatedButton(
              label: currentIndex != 2 ? 'Next' : 'Done',
              onPress: () {
                if (currentIndex != 2) {
                  setState(() {
                    currentIndex = currentIndex + 1;
                  });

                  _pageController.animateToPage(currentIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                } else {
                  // navigate to login screen
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              })
        ],
      ),
    );
  }

  // single page view item
  Widget pageItem(Onboarding item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: Svg(item.imageUrl), width: 350, height: 150),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

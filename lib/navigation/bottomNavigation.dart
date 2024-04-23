import 'package:courier_rider/screens/order/order_list.dart';
import 'package:courier_rider/screens/profile/contact_data_screen.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:courier_rider/widgets/widgets.dart';

// utils
import "package:courier_rider/utils/utils.dart";

// screens
import 'package:courier_rider/screens/screens.dart';

class AppBottomNavigation extends StatefulWidget {
  const AppBottomNavigation({super.key});

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: AppColors.primary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: UIIcon(
              iconData: Icons.home,
              iconColor: AppColors.white,
            ),
            icon: UIIcon(iconData: Icons.home_outlined),
            label: 'HOME',
          ),
          NavigationDestination(
            selectedIcon: UIIcon(
              iconData: Icons.list,
              iconColor: AppColors.white,
            ),
            icon: UIIcon(iconData: Icons.list_alt_outlined),
            label: "Orders",
          ),
          NavigationDestination(
              selectedIcon: UIIcon(
                iconData: Icons.person,
                iconColor: AppColors.white,
              ),
              icon: UIIcon(iconData: Icons.person),
              label: "Profile")
        ],
      ),
      body: const [
        HomeScreen(),
        OrderListScreen(),
        ProfileScreen()
      ][currentPageIndex],
    );
  }
}

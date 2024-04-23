import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// screens
import 'package:courier_rider/screens/screens.dart';

// utils
import 'package:courier_rider/utils/utils.dart';

// service
import 'package:courier_rider/services/endpoints.dart';

// navigation
import 'package:courier_rider/navigation/bottomNavigation.dart';

// routes
import 'package:courier_rider/routes/routes.dart';

// providers
import 'package:courier_rider/provider/providers.dart';

void main() {
  // setting up environment
  Endpoints.setEnvironment(Environment.development);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn = false;

  getLoggedInState() async {
    await Helper.getData<String>(Constants.user).then((value) {
      if (value == null) {
        setState(() {
          userLoggedIn = false;
        });
      } else {
        setState(() {
          userLoggedIn = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getLoggedInState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Courier App",
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          routes: {
            Routes.loginScreen: (context) => const LoginScreen(),
          },
          /* home: userLoggedIn == true
            ? const AppBottomNavigation()
            : const LoginScreen() */
          home: LoginScreen()),
    );
  }
}

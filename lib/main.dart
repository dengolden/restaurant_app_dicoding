import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/pages/main_page.dart';
import 'package:restaurant_app_1/pages/onboarding_page.dart';
import 'package:restaurant_app_1/pages/splash_screen_page.dart';
import 'package:restaurant_app_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_1/services/restaurant_api_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(
            restaurantService: RestaurantService(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreenPage(),
        '/on-boarding': (context) => OnBoardingPage(),
        '/main': (context) => MainPage(),
      },
    );
  }
}

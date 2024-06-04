import 'package:flutter/material.dart';
import 'package:restaurant_app_1/pages/home_page.dart';
import 'package:restaurant_app_1/shared/theme.dart';
import 'package:restaurant_app_1/widgets/bottom_navigation_item.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent() {
      return HomePage();
    }

    Widget bottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 85,
          padding: EdgeInsets.symmetric(
            horizontal: 58,
          ),
          decoration: BoxDecoration(
            color: darkGreyColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavigationItem(
                imageUrl: 'assets/home_icon.png',
                isActive: true,
              ),
              BottomNavigationItem(
                imageUrl: 'assets/explore_icon.png',
              ),
              BottomNavigationItem(
                imageUrl: 'assets/favorite_icon.png',
              ),
              BottomNavigationItem(
                imageUrl: 'assets/profile_setting_icon.png',
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            buildContent(),
            bottomNavigation(),
          ],
        ),
      ),
    );
  }
}

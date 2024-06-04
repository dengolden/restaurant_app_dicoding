import 'package:flutter/material.dart';
import 'package:restaurant_app_1/shared/theme.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              height: 432,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    blackColor,
                    blackColor.withOpacity(0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: 585,
              ),
              child: Column(
                children: [
                  Text(
                    'Find your comfort\nplace to visit',
                    style: boldTextStyle.copyWith(
                      color: whiteColor,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Explore culinary delights around every corner',
                    style: regularTextStyle.copyWith(
                      color: whiteColor,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: darkPurpleColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/main');
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: whiteColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

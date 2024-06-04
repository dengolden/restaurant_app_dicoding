import 'package:flutter/material.dart';
import 'package:restaurant_app_1/shared/theme.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, '/on-boarding');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 340,
              ),
              width: 99,
              height: 99,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Restaurant\nApp',
              style: boldTextStyle.copyWith(
                fontSize: 24,
                color: whiteColor,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

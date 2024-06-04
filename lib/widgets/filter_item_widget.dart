import 'package:flutter/material.dart';
import 'package:restaurant_app_1/shared/theme.dart';

class FilterItemWidget extends StatelessWidget {
  final String title;
  final bool isActive;

  const FilterItemWidget({
    required this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      margin: EdgeInsets.only(right: 7),
      padding: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: isActive ? whiteColor : darkGreyColor,
        borderRadius: BorderRadius.circular(
          defaultRadius,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: mediumTextStyle.copyWith(
            color: isActive ? blackColor : whiteColor,
          ),
        ),
      ),
    );
  }
}

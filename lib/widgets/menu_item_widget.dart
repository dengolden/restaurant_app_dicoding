import 'package:flutter/material.dart';
import 'package:restaurant_app_1/model/restaurant_detail.dart';
import 'package:restaurant_app_1/shared/theme.dart';

class MenutItemWidget extends StatelessWidget {
  final Menus menus;

  const MenutItemWidget({required this.menus});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Foods:',
          style: regularTextStyle.copyWith(
            color: whiteColor,
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: menus.foods.length,
            itemBuilder: (context, index) {
              Category food = menus.foods[index];
              return Row(
                children: [
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      color: lightPurpleColor,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: darkPurpleColor,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/food_icon.png',
                            width: 16,
                            height: 16,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          food.name,
                          style: mediumTextStyle.copyWith(color: whiteColor),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Drinks:',
          style: regularTextStyle.copyWith(
            color: whiteColor,
          ),
        ),
        Container(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: menus.drinks.length,
            itemBuilder: (context, index) {
              Category drink = menus.drinks[index];
              return Row(
                children: [
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      color: lightVioletColor,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: darkVioletColor,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/drink_icon.png',
                            width: 16,
                            height: 16,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          drink.name,
                          style: mediumTextStyle.copyWith(color: blackColor),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

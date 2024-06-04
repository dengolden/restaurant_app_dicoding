import 'package:flutter/material.dart';
import 'package:restaurant_app_1/model/restaurant_list.dart';
import 'package:restaurant_app_1/shared/theme.dart';

class RestaurantItemWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItemWidget({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 225,
      margin: EdgeInsets.only(
        right: 25,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        image: DecorationImage(
          image: NetworkImage(
            'https://restaurant-api.dicoding.dev/images/large/' +
                restaurant.pictureId,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 150,
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
          Container(
            margin: EdgeInsets.only(
              top: 155,
              left: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: semiBoldTextStyle.copyWith(
                    color: whiteColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 22,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        color: darkGreyColor,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: whiteColor,
                            size: 20,
                          ),
                          SizedBox(width: 2),
                          Text(
                            restaurant.city,
                            style: regularTextStyle.copyWith(
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      height: 22,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        color: darkGreyColor,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: goldColor,
                            size: 20,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: mediumTextStyle.copyWith(
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

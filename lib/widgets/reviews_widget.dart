import 'package:flutter/material.dart';
import 'package:restaurant_app_1/model/restaurant_detail.dart';
import 'package:restaurant_app_1/shared/theme.dart';

class ReviewsWidget extends StatelessWidget {
  final List<CustomerReview> customerReview;

  const ReviewsWidget({required this.customerReview});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: customerReview.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final review = customerReview[index];
          return Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 12,
                  right: 17,
                ),
                width: 230,
                height: 125,
                padding: EdgeInsets.only(
                  top: 8,
                  left: 7,
                  right: 7,
                ),
                decoration: BoxDecoration(
                  color: darkGreyColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 27,
                          height: 27,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/profile_setting_icon.png',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                review.name,
                                style: semiBoldTextStyle.copyWith(
                                  color: whiteColor,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                review.date,
                                style: regularTextStyle.copyWith(
                                  color: whiteColor,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      review.review,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: regularTextStyle.copyWith(
                        color: whiteColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

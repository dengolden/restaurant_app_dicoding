import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/model/restaurant_detail.dart';
import 'package:restaurant_app_1/pages/create_review_page.dart';
import 'package:restaurant_app_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_1/services/restaurant_api_service.dart';
import 'package:restaurant_app_1/shared/theme.dart';
import 'package:restaurant_app_1/widgets/menu_item_widget.dart';
import 'package:restaurant_app_1/widgets/reviews_widget.dart';

class DetailPage extends StatelessWidget {
  final String restaurantId;
  final RestaurantService restaurantService;

  const DetailPage({
    required this.restaurantId,
    required this.restaurantService,
  });

  @override
  Widget build(BuildContext context) {
    Future.microtask(() =>
        Provider.of<RestaurantProvider>(context, listen: false)
            .fetchRestaurantDetail(restaurantId));
    return Scaffold(
      backgroundColor: blackColor,
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingDetail) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.detailErrorMessage.isNotEmpty) {
            return Center(
              child: Text(
                'Sorry, There is no Internet Connection :(',
                style: regularTextStyle.copyWith(
                  color: whiteColor,
                  fontSize: 16,
                ),
              ),
            );
          } else if (provider.restaurantDetail != null) {
            RestaurantDetail restaurantDetail = provider.restaurantDetail!;
            return buildContentDetail(context, restaurantDetail);
          } else {
            return Center(
              child: Text('Data tidak ditemukan'),
            );
          }
        },
      ),
    );
  }
}

Widget buildContentDetail(
    BuildContext context, RestaurantDetail restaurantDetail) {
  Widget restaurantInfo() {
    Widget restaurantMainInfo() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          top: 400,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurantDetail.name,
              style: semiBoldTextStyle.copyWith(
                color: whiteColor,
                fontSize: 26,
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
                        restaurantDetail.city,
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
                        restaurantDetail.rating.toString(),
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
      );
    }

    Widget backgroundImage() {
      return Stack(
        children: [
          Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://restaurant-api.dicoding.dev/images/large/' +
                      restaurantDetail.pictureId,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: double.infinity,
              height: 170,
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
              child: Container(
                margin: EdgeInsets.only(
                  left: defaultMargin,
                  top: 420,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: defaultMargin,
                  top: 20,
                ),
                width: 40,
                height: 40,
                padding: EdgeInsets.only(
                  left: 6,
                  right: 6,
                ),
                decoration: BoxDecoration(
                  color: blackColor.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: whiteColor,
                    size: 22,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: defaultMargin,
                  top: 20,
                ),
                width: 40,
                height: 40,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: blackColor.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/favorite_icon.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Stack(
      children: [
        backgroundImage(),
        restaurantMainInfo(),
      ],
    );
  }

  Widget descriptionBox() {
    return Container(
      margin: EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
      ),
      padding: EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultRadius),
        color: darkGreyColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: semiBoldTextStyle.copyWith(
              color: whiteColor,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 7),
          ReadMoreText(
            restaurantDetail.description,
            trimMode: TrimMode.Line,
            trimLines: 4,
            trimCollapsedText: '\n Read More',
            trimExpandedText: '\n Show Less',
            style: regularTextStyle.copyWith(
              color: whiteColor,
            ),
            moreStyle: boldTextStyle.copyWith(color: lightVioletColor),
            lessStyle: boldTextStyle.copyWith(color: lightVioletColor),
          ),
        ],
      ),
    );
  }

  Widget restaurantMenu(Menus menus) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        left: defaultMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore the Menu\'s',
            style: semiBoldTextStyle.copyWith(
              color: whiteColor,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 6),
          MenutItemWidget(menus: menus),
        ],
      ),
    );
  }

  Widget reviews(List<CustomerReview> customerReview) {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
        left: defaultMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews',
            style: semiBoldTextStyle.copyWith(
              fontSize: 20,
              color: whiteColor,
            ),
          ),
          ReviewsWidget(customerReview: customerReview),
          SizedBox(
            height: 25,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateReviewPage(
                      restaurantId: restaurantDetail.id,
                    ),
                  ),
                );
              },
              child: Container(
                width: 200,
                height: 38,
                padding: EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                decoration: BoxDecoration(
                  color: darkGreyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.create,
                      color: whiteColor,
                      size: 20,
                    ),
                    SizedBox(width: 2),
                    Text(
                      'Write your own review',
                      style: semiBoldTextStyle.copyWith(
                        color: whiteColor,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  return ListView(
    scrollDirection: Axis.vertical,
    children: [
      restaurantInfo(),
      descriptionBox(),
      restaurantMenu(restaurantDetail.menus),
      reviews(restaurantDetail.customerReviews),
    ],
  );
}

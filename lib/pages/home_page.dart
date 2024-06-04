import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/model/restaurant_list.dart';
import 'package:restaurant_app_1/pages/detail_page.dart';
import 'package:restaurant_app_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_1/services/restaurant_api_service.dart';
import 'package:restaurant_app_1/shared/theme.dart';
import 'package:restaurant_app_1/widgets/filter_item_widget.dart';
import 'package:restaurant_app_1/widgets/restaurant_item_widget.dart';
import 'package:restaurant_app_1/widgets/search_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() =>
        Provider.of<RestaurantProvider>(context, listen: false)
            .fetchRestaurantList());
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: 15,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Dicoding!',
                  style: semiBoldTextStyle.copyWith(
                    color: whiteColor,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 25,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: darkGreyColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: whiteColor,
                        size: 16,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Surabaya',
                        style: mediumTextStyle.copyWith(
                          color: whiteColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profile_icon.png'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget searchBox() {
      return SearchWidget();
    }

    Widget filterLocation() {
      // COMING SOON!
      return Container(
        margin: EdgeInsets.only(
          top: 21,
          left: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter by Location',
              style: regularTextStyle.copyWith(
                color: whiteColor,
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterItemWidget(
                    title: 'All',
                    isActive: true,
                  ),
                  FilterItemWidget(
                    title: 'Bali',
                  ),
                  FilterItemWidget(
                    title: 'Surabaya',
                  ),
                  FilterItemWidget(
                    title: 'Jakarta',
                  ),
                  FilterItemWidget(
                    title: 'Manado',
                  ),
                  FilterItemWidget(
                    title: 'Makassar',
                  ),
                  FilterItemWidget(
                    title: 'Bandung',
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget restaurantList() {
      final RestaurantService restaurantService = RestaurantService();

      return Container(
        margin: EdgeInsets.only(
          top: 22,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Out Here',
              style: boldTextStyle.copyWith(
                color: whiteColor,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 9),
            Consumer<RestaurantProvider>(
              builder: (context, provider, child) {
                if (provider.isLoadingList) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.listErrorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      'Sorry, There is no Internet Connection :(',
                      style: regularTextStyle.copyWith(
                        color: whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: ${provider.restaurants.length.toString()} Places',
                        style: regularTextStyle.copyWith(
                          color: whiteColor,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: provider.restaurants.length,
                          itemBuilder: (context, index) {
                            Restaurant restaurant = provider.restaurants[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      restaurantId: restaurant.id,
                                      restaurantService: restaurantService,
                                    ),
                                  ),
                                );
                              },
                              child:
                                  RestaurantItemWidget(restaurant: restaurant),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            // Space for landscape view
            SizedBox(
              height: 60,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            searchBox(),
            filterLocation(),
            restaurantList(),
          ],
        ),
      ),
    );
  }
}

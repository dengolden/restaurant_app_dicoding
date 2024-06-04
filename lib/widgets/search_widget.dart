import 'package:flutter/material.dart';
import 'package:restaurant_app_1/model/restaurant_list.dart';
import 'package:restaurant_app_1/pages/detail_page.dart';
import 'package:restaurant_app_1/services/restaurant_api_service.dart';
import 'package:restaurant_app_1/shared/theme.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _searchController = TextEditingController();
  List<Restaurant> _searchResults = [];
  bool _isLoading = false;
  String _errorMessage = '';

  void _searchRestaurants(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final results = await RestaurantService().searchRestaurant(query);
      setState(() {
        _searchResults = results;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        left: 15,
        right: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 41,
            decoration: BoxDecoration(
              color: darkPurpleColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              cursorColor: whiteColor,
              cursorHeight: 16,
              controller: _searchController,
              style: regularTextStyle.copyWith(
                fontSize: 15,
                color: whiteColor,
              ),
              decoration: InputDecoration(
                hoverColor: whiteColor,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: whiteColor,
                  size: 20,
                ),
                hintText: 'Search by name and menu..',
                hintStyle: regularTextStyle.copyWith(
                  color: whiteColor.withOpacity(0.7),
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  _searchRestaurants(query);
                }
              },
            ),
          ),
          SizedBox(height: 9),
          Text(
            'Search result: ',
            style: regularTextStyle.copyWith(
              color: whiteColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 10),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
                  ? Center(child: Text(_errorMessage))
                  : _searchResults.isNotEmpty
                      ? Container(
                          height: 170,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _searchResults.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final restaurant = _searchResults[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        restaurantId: restaurant.id,
                                        restaurantService: RestaurantService(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 145,
                                  height: 160,
                                  margin: EdgeInsets.only(right: 13),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(defaultRadius),
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
                                          height: 130,
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
                                          top: 125,
                                          left: 6,
                                        ),
                                        child: Text(
                                          restaurant.name,
                                          style: semiBoldTextStyle.copyWith(
                                            color: whiteColor,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 150,
                                          left: 6,
                                        ),
                                        child: Text(
                                          restaurant.city,
                                          style: regularTextStyle.copyWith(
                                              color: whiteColor, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            'No results found',
                            style: regularTextStyle.copyWith(
                              color: lightGreyColor,
                            ),
                          ),
                        ),
        ],
      ),
    );
  }
}

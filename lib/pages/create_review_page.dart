import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/model/restaurant_detail.dart';
import 'package:restaurant_app_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_1/shared/theme.dart';

class CreateReviewPage extends StatefulWidget {
  final String restaurantId;

  CreateReviewPage({required this.restaurantId});

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: darkGreyColor,
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
                  top: 30,
                  left: defaultMargin,
                ),
                child: Text(
                  'Create Review',
                  style: boldTextStyle.copyWith(
                    color: whiteColor,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 21,
                  left: defaultMargin,
                ),
                child: Text(
                  'Input your name',
                  style: regularTextStyle.copyWith(
                    color: lightGreyColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(
                    color: darkGreyColor,
                    width: 1,
                  ),
                ),
                child: TextFormField(
                  controller: _nameController,
                  style: regularTextStyle.copyWith(
                    color: whiteColor,
                  ),
                  decoration: InputDecoration(
                    hintStyle: regularTextStyle.copyWith(
                      color: darkGreyColor,
                    ),
                    hintText: 'Type here...',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 21,
                  left: defaultMargin,
                ),
                child: Text(
                  'Write your review',
                  style: regularTextStyle.copyWith(
                    color: lightGreyColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(
                    color: darkGreyColor,
                    width: 1,
                  ),
                ),
                child: TextFormField(
                  controller: _reviewController,
                  style: regularTextStyle.copyWith(
                    color: whiteColor,
                  ),
                  maxLines: null,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintStyle: regularTextStyle.copyWith(
                      color: darkGreyColor,
                    ),
                    hintText: 'Type here...',
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<RestaurantProvider>(
                  builder: (context, provider, child) {
                    return provider.isSubmittingReview
                        ? CircularProgressIndicator()
                        : Container(
                            width: 180,
                            height: 55,
                            decoration: BoxDecoration(
                              color: darkGreyColor,
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                final review = CustomerReview(
                                    name: _nameController.text,
                                    review: _reviewController.text,
                                    date: '');
                                await provider.submitReview(
                                    widget.restaurantId, review);
                                if (provider.submitReviewErrorMessage.isEmpty) {
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          provider.submitReviewErrorMessage),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Submit your review',
                                style: semiBoldTextStyle.copyWith(
                                  color: whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

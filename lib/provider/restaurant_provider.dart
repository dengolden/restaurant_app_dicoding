import 'package:flutter/material.dart';
import 'package:restaurant_app_1/model/restaurant_detail.dart';
import 'package:restaurant_app_1/model/restaurant_list.dart';
import 'package:restaurant_app_1/services/restaurant_api_service.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantService restaurantService;

  //Restaurant List
  List<Restaurant> _restaurants = [];
  bool _isLoadingList = false;
  String _listErrorMessage = '';

  //Restaurant Detail
  RestaurantDetail? _restaurantDetail;
  bool _isLoadingDetail = false;
  String _detailErrorMessage = '';

  //Create Review
  bool _isSubmittingReview = false;
  String _submitReviewErrorMessage = '';

  // Getters
  List<Restaurant> get restaurants => _restaurants;
  bool get isLoadingList => _isLoadingList;
  String get listErrorMessage => _listErrorMessage;

  RestaurantDetail? get restaurantDetail => _restaurantDetail;
  bool get isLoadingDetail => _isLoadingDetail;
  String get detailErrorMessage => _detailErrorMessage;

  bool get isSubmittingReview => _isSubmittingReview;
  String get submitReviewErrorMessage => _submitReviewErrorMessage;

  RestaurantProvider({required this.restaurantService});

  Future<void> fetchRestaurantList() async {
    _isLoadingList = true;
    _listErrorMessage = '';
    notifyListeners();

    try {
      _restaurants = await restaurantService.fetchRestaurantList();
      print('Fetched ${_restaurants.length} restaurants');
    } catch (e) {
      _listErrorMessage = e.toString();
      print('Error fetching restaurants: $_listErrorMessage');
    } finally {
      _isLoadingList = false;
      notifyListeners();
    }
  }

  Future<void> fetchRestaurantDetail(String id) async {
    _isLoadingDetail = true;
    _detailErrorMessage = '';
    notifyListeners();

    try {
      _restaurantDetail = await restaurantService.fetchRestaurantDetail(id);
    } catch (e) {
      _detailErrorMessage = e.toString();
    } finally {
      _isLoadingDetail = false;
      notifyListeners();
    }
  }

  Future<void> submitReview(String id, CustomerReview review) async {
    _isSubmittingReview = true;
    _submitReviewErrorMessage = '';
    notifyListeners();

    try {
      final reviews = CustomerReview(
        name: review.name,
        review: review.review,
        date: DateTime.now().toIso8601String(),
      );
      await restaurantService.submitReview(id, reviews);
      await fetchRestaurantDetail(id);
    } catch (e) {
      _submitReviewErrorMessage = e.toString();
    } finally {
      _isSubmittingReview = false;
      notifyListeners();
    }
  }
}

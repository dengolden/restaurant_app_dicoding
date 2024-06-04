import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_1/model/restaurant_detail.dart';
import 'package:restaurant_app_1/model/restaurant_list.dart';

class RestaurantService {
  final baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<List<Restaurant>> fetchRestaurantList() async {
    final url = Uri.parse('$baseUrl/list');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data.containsKey('restaurants')) {
        List<Restaurant> restaurants = (data['restaurants'] as List)
            .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
            .toList();
        return restaurants;
      } else {
        print('No restaurants key in response');
        return [];
      }
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      throw Exception('Gagal mengambil data restoran: ${response.statusCode}');
    }
  }

  Future<RestaurantDetail> fetchRestaurantDetail(String id) async {
    final url = Uri.parse('$baseUrl/detail/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data.containsKey('restaurant')) {
        RestaurantDetail restaurantDetail =
            RestaurantDetail.fromJson(data['restaurant']);
        return restaurantDetail;
      } else {
        throw Exception('Data detail restoran tidak ditemukan');
      }
    } else {
      throw Exception(
          'Gagal mengambil data detail restoran: ${response.statusCode}');
    }
  }

  Future<List<Restaurant>> searchRestaurant(String query) async {
    final url = Uri.parse('$baseUrl/search?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data.containsKey('restaurants')) {
        List<Restaurant> restaurants = (data['restaurants'] as List)
            .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
            .toList();
        return restaurants;
      } else {
        return [];
      }
    } else {
      throw Exception(
          'Gagal mengambil data pencarian restoran: ${response.statusCode}');
    }
  }

  Future<void> submitReview(String id, CustomerReview review) async {
    final url = Uri.parse('$baseUrl/review');
    final response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'name': review.name,
        'review': review.review,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal mengirim Review');
    }
  }
}

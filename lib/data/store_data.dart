import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skill_test_patch/enums.dart';
import 'package:flutter_skill_test_patch/model/catergory.dart';
import 'package:flutter_skill_test_patch/model/product.dart';

import 'package:http/http.dart' as http;

final apiServiceProvider = Provider((ref) => APIService());

class APIService {
  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Category>> fetchCategories() async {
    try {
      final result = <Category>[];

      final response = await http.get(Uri.parse('$baseUrl/categories'));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        //Since the API does not return their images, we will use local images
        final List<String> categories = List<String>.from(jsonDecode(response.body));
        for (String category in categories) {
          String path = '';

          switch (category) {
            case 'electronics':
              path = 'assets/images/electronics.jpg';
              break;
            case 'jewelery':
              path = 'assets/images/jewelry.jpg';
              break;
            case "men's clothing":
              path = 'assets/images/mens_wear.jpg';
              break;
            case "women's clothing":
              path = 'assets/images/womens_wear.png';
              break;
            default:
              path = 'assets/images/electronics.jpg';
              break;
          }

            result.add(Category(key: category, name: category[0].toUpperCase() + category.substring(1), imagePath: path));
        }
      } else {
        throw Exception('Failed to load categories');
      }

      return result;
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> fetchProducts({String? category, PriceSort? priceSort}) async {
    try {
      final result = <Product>[];

      var url = baseUrl;

      //Add the filters
      if (category != null) {
        url = '$baseUrl/category/$category';
      }

      url = '$url?limit=50';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final List<dynamic> products = jsonDecode(response.body);

        for (Map<String, dynamic> product in products) {
          result.add(Product.fromJson(product));
        }

        //Sort by product price here since the API does not support sorting by price
        if (priceSort != null) {
          result.sort((a, b) {
            if (priceSort == PriceSort.lowToHigh) {
              return a.price!.compareTo(b.price!);
            } else {
              return b.price!.compareTo(a.price!);
            }
          });
        }

        return result;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skill_test_patch/model/catergory.dart';

final apiServiceProvider = Provider((ref) => APIService());

class APIService {
  //TODO: Fetch categories from FakeStore
  Future<List<Category>> fetchCategories() async {
    //Just for simulating delay :)
    await Future.delayed(Duration(seconds: 2));
    return [
      Category(name: 'Electronics', imagePath: 'assets/images/electronics.jpg'),
      Category(name: 'Jewelry', imagePath: 'assets/images/jewelry.jpg'),
      Category(name: "Men's Wear", imagePath: 'assets/images/mens_wear.jpg'),
      Category(name: "Women's Wear", imagePath: 'assets/images/womens_wear.png')
    ];
  }

  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Hello World';
  }
}
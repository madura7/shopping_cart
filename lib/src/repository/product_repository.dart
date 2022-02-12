import 'package:shopping_cart/src/model/product_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class ProductRepository {
  Client client = Client();

  Future<ProductFromBackend> getProducts() async {
    const url = "https://run.mocky.io/v3/919a0d45-c054-4452-8175-65538e554272";

    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return ProductFromBackend.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

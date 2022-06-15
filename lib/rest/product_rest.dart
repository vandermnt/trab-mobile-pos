import 'package:http/http.dart' as http;
import 'package:trab_mobile_pos/model/product.dart';
import 'package:trab_mobile_pos/shared/config.dart';

class ProductRest {
  Future<List<Product>> getAll() async {
    var url = Uri.parse('${Config.baseUrl}/products');
    http.Response? response;

    try {
      response = await http.get(url);
      return Product.fromJsonList(response.body);
    } catch (error) {
      throw error;
    }
  }

  Future<Product> create(Product product) async {
    var url = Uri.parse('${Config.baseUrl}/products');
    http.Response? response;

    try {
      response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: Product.toJson(product));

      if (response.statusCode == 201) {
        return Product.fromJson(response.body);
      }

      throw Exception("Error create product!");
    } catch (error) {
      throw error;
    }
  }

  Future<void> delete(int productId) async {
    var url = Uri.parse('${Config.baseUrl}/products/$productId');
    http.Response? response;

    try {
      response = await http.delete(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        return;
      }

      throw Exception("Error delete product!");
    } catch (error) {
      throw error;
    }
  }

  Future<void> update(Product product) async {
    var url = Uri.parse('${Config.baseUrl}/products/${product.id}');
    http.Response? response;

    try {
      response = await http.put(url,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: Product.toJson(product));

      if (response.statusCode == 200) {
        return;
      }

      throw Exception("Error update product!");
    } catch (error) {
      throw error;
    }
  }
}

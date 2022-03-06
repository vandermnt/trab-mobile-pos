import 'package:http/http.dart' as http;
import 'package:trab_mobile_pos/model/product.dart';
import 'package:trab_mobile_pos/shared/config.dart';

class ProductRest {
  Future<List<Product>> getAll() async {
    try {
      print(Config.baseUrl);
    } catch (error) {
      print(error);
    }
    var url = Uri.parse('${Config.baseUrl}/products');
    http.Response? response;

    try {
      response = await http.get(url);
      return Product.fromJsonList(response.body);
    } catch (error) {
      throw error;
    }
  }

  Future<Product> create(Product client) async {
    var url = Uri.parse('${Config.baseUrl}/products');
    http.Response? response;

    try {
      response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: Product.toJson(client));

      if (response.statusCode == 201) {
        return Product.fromJson(response.body);
      }

      throw Exception("Error create product!");
    } catch (error) {
      throw error;
    }
  }
}

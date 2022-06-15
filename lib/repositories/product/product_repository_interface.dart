import 'package:trab_mobile_pos/model/product.dart';

abstract class IProductRepository {
  Future<List<Product>> getAll();
  Future<Product> create(Product product);
  Future<void> update(Product product);
  Future<void> delete(int product);
}

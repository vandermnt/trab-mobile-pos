import 'package:trab_mobile_pos/model/product.dart';

abstract class IProductRepository {
  Future<List<Product>> getAll();
  Future<Product> getProdutcById();
  Future<Product> create(Product product);
  Future<Product> update(Product product);
  Future<void> delete(int product);
}

import 'package:trab_mobile_pos/model/product.dart';

abstract class IProductRepository {
  Future<List<Product>> getAll();
  Future<Product> getProdutcById();
  Future<Product> create(Product produtc);
  Future<Product> update(Product produtc);
  Future<Product> delete(Product produtc);
}

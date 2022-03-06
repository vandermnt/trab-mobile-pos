import 'package:trab_mobile_pos/model/product.dart';
import 'package:trab_mobile_pos/repositories/product/product_repository_interface.dart';
import 'package:trab_mobile_pos/rest/product_rest.dart';

class ProductRepository implements IProductRepository {
  final ProductRest api = ProductRest();

  @override
  Future<Product> create(Product produtc) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Product> delete(Product produtc) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getAll() async {
    return await api.getAll();
  }

  @override
  Future<Product> getProdutcById() {
    // TODO: implement getProdutcById
    throw UnimplementedError();
  }

  @override
  Future<Product> update(Product produtc) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

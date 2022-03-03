import 'package:trab_mobile_pos/model/product.dart';
import 'package:trab_mobile_pos/repositories/product/product_repository_interface.dart';
import 'package:trab_mobile_pos/rest/client_rest.dart';

class ProductRepository implements IProductRepository {
  final ClientRest api = ClientRest();

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
  Future<List<Product>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
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

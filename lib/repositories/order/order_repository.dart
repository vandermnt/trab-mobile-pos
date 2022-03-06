import 'package:trab_mobile_pos/model/client.dart';
import 'package:trab_mobile_pos/model/order.dart';
import 'package:trab_mobile_pos/rest/client_rest.dart';

import 'order_repository_interface.dart';

class OrderRepository implements IOrderRepository {
  final ClientRest api = ClientRest();

  @override
  Future<Order> create(Order client) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Order> delete(Order client) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Order> getClientById() {
    // TODO: implement getClientById
    throw UnimplementedError();
  }

  @override
  Future<Order> update(Order client) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

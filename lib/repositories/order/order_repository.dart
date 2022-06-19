import 'package:trab_mobile_pos/model/order.dart';
import 'package:trab_mobile_pos/rest/order_rest.dart';

import 'order_repository_interface.dart';

class OrderRepository implements IOrderRepository {
  final OrderRest api = OrderRest();

  @override
  Future<Order> create(Order client) async {
    return await api.create(client);
  }

  @override
  Future<void> delete(Order order) async {
    return await api.delete(order.id!);
  }

  @override
  Future<List<Order>> getAll() async {
    return await api.getAll();
  }

  @override
  Future<List<Order>> getAllByCpf(String cpf) async {
    return await api.getAllByCpf(cpf);
  }
}

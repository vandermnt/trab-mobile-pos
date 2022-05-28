import 'package:trab_mobile_pos/model/order.dart';

abstract class IOrderRepository {
  Future<List<Order>> getAll();
  Future<Order> getClientById();
  Future<Order> create(Order client);
  Future<Order> update(Order client);
  Future<void> delete(Order client);
}

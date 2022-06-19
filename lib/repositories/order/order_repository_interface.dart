import 'package:trab_mobile_pos/model/order.dart';

abstract class IOrderRepository {
  Future<List<Order>> getAll();
  Future<List<Order>> getAllByCpf(String cpf);
  Future<Order> create(Order client);
  Future<void> delete(Order client);
}

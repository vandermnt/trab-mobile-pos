import 'package:trab_mobile_pos/model/client.dart';

abstract class IClientRepository {
  Future<List<Client>> getAll();
  Future<Client> getClientById();
  Future<Client> create(Client client);
  Future<void> update(Client client);
  Future<void> delete(int client);
}

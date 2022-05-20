import 'package:trab_mobile_pos/model/client.dart';
import 'package:trab_mobile_pos/rest/client_rest.dart';

import 'client_repository_interface.dart';

class ClientRepository implements IClientRepository {
  final ClientRest api = ClientRest();

  @override
  Future<Client> create(Client client) async {
    return await api.create(client);
  }

  @override
  Future<void> delete(int clientId) {
    return api.delete(clientId);
  }

  @override
  Future<List<Client>> getAll() async {
    return await api.getAll();
  }

  @override
  Future<Client> getClientById() {
    // TODO: implement getClientById
    throw UnimplementedError();
  }

  @override
  Future<Client> update(Client client) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

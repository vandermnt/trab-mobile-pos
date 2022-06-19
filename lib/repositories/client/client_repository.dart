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

  Future<Client?> getClientByCpf(String cpf) async {
    return await api.getByCpf(cpf);
  }

  @override
  Future<void> update(Client client) async {
    return await api.update(client);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:trab_mobile_pos/model/client.dart';
import 'package:trab_mobile_pos/repositories/client/client_repository.dart';
import 'package:trab_mobile_pos/view/client/create_client_page.dart';

import 'edit_client_page.dart';

class ListClientPage extends StatefulWidget {
  ListClientPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _ListClientPageState();
}

class _ListClientPageState extends State<ListClientPage> {
  List<Client> clients = [];

  late final ScrollController _scrollController;
  final ClientRepository clientRepository = ClientRepository();

  @override
  void initState() {
    super.initState();
    this.getAllClients();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clientes")),
      body: CupertinoListView.builder(
        padding: new EdgeInsets.all(20.0),
        sectionCount: 1,
        itemInSectionCount: (section) => clients.length,
        sectionBuilder: _buildSection,
        childBuilder: _buildItem,
        separatorBuilder: _buildSeparator,
        controller: _scrollController,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => CreateClientPage()))
                .then((value) => getAllClients());
          },
        ),
      ),
    );
  }

  Widget _buildSeparator(BuildContext context, IndexPath index) {
    return Divider(indent: 20.0, endIndent: 20.0);
  }

  Widget _buildSection(
      BuildContext context, SectionPath index, bool isFloating) {
    return Container();
  }

  Widget _buildItem(BuildContext context, IndexPath index) {
    return Container(
      constraints: BoxConstraints(minHeight: 50.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              child: Text(clients[index.child].name! +
                  ' ' +
                  clients[index.child].lastName!),
              width: 120.0),
          Spacer(),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 'edit', child: Text('Editar')),
                PopupMenuItem(value: 'delete', child: Text('Remover'))
              ];
            },
            onSelected: (String value) {
              if (value == 'edit') {
                Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                EditClientPage(client: clients[index.child])))
                    .then((value) => getAllClients());
              }
              if (value == 'delete') delete(clients[index.child].id);
            },
          )
        ],
      ),
    );
  }

  Future getAllClients() async {
    final clientsFromRepository = await clientRepository.getAll();

    setState(() {
      clients = clientsFromRepository;
    });
  }

  Future delete(clientId) async {
    await clientRepository.delete(clientId);

    await getAllClients();
  }
}

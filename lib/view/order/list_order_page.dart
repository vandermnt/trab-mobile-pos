import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:trab_mobile_pos/model/order.dart';
import 'package:trab_mobile_pos/repositories/order/order_repository.dart';
import 'package:trab_mobile_pos/view/order/create_order_page.dart';

class ListOrderPage extends StatefulWidget {
  ListOrderPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _ListOrderPage();
}

class _ListOrderPage extends State<ListOrderPage> {
  // final _data = Section.allData();

  List<Order> clients = [];

  late final ScrollController _scrollController;
  final OrderRepository orderRepository = OrderRepository();

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(title: Text("Pedidos")),
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
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => CreateOrderPage()));
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
              child: Text(clients[index.child].name as String), width: 120.0),
          Spacer(),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 'edit', child: Text('Editar')),
                PopupMenuItem(value: 'delete', child: Text('Remover'))
              ];
            },
            onSelected: (String value) {},
          )
        ],
      ),
    );
  }
}

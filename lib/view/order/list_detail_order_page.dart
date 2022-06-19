import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trab_mobile_pos/model/order.dart';
import 'package:trab_mobile_pos/repositories/order/order_repository.dart';

class ListDetailOrderPage extends StatefulWidget {
  late Order order;

  ListDetailOrderPage({Key? key, required this.order}) : super(key: key);

  List<DataRow> rows = [];

  @override
  State createState() => _ListDetailOrderPage();
}

class _ListDetailOrderPage extends State<ListDetailOrderPage> {
  List<Order> orders = [];

  final TextEditingController cpf = TextEditingController();
  final OrderRepository orderRepository = OrderRepository();
  late final ScrollController _scrollController;
  List<DataRow> rows = [];

  @override
  void initState() {
    widget.order.items?.forEach((item) {
      rows.add(DataRow(cells: [
        DataCell(
          Text(item.product?.description as String),
        ),
        DataCell(
          Text(item.quantity as String),
        ),
      ]));
    });
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
      appBar: AppBar(title: Text("Detalhes do Pedido")),
      body: Column(
        children: [
          Container(
            constraints: BoxConstraints(minHeight: 50.0),
            child: Column(
              children: [
                SizedBox(
                  child: ListTile(
                    title: Text('Pedido ' + widget.order.id.toString() + ' '),
                    subtitle: Text("Cliente: " +
                        ' ' +
                        (widget.order.client?.name as String) +
                        '\n' +
                        'Data: ' +
                        DateFormat('dd/MM/yyyy HH:mm')
                            .format(widget.order.date!)),
                  ),
                ),
                Text(
                  "ITENS:",
                  textAlign: TextAlign.left,
                ),
                DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Produto',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Quantidade',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: rows,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

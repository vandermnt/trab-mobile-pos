import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:trab_mobile_pos/model/order.dart';
import 'package:trab_mobile_pos/repositories/order/order_repository.dart';
import 'package:trab_mobile_pos/view/order/create_order_page.dart';
import 'package:trab_mobile_pos/view/order/list_detail_order_page.dart';

class ListOrderPage extends StatefulWidget {
  ListOrderPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _ListOrderPage();
}

class _ListOrderPage extends State<ListOrderPage> {
  List<Order> orders = [];

  final TextEditingController cpf = TextEditingController();
  final OrderRepository orderRepository = OrderRepository();
  late final ScrollController _scrollController;

  String? _errorCpf;
  bool _filteredByCpf = false;

  @override
  void initState() {
    super.initState();
    getAllOrders();
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
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
            decoration: BoxDecoration(
              color: const Color(0xffe2f1fc),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: cpf,
                    decoration: new InputDecoration(
                        hintText: 'Filtrar pedidos pelo CPF...',
                        errorText: _errorCpf),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
                () {
                  if (_filteredByCpf) {
                    return IconButton(
                        onPressed: () {
                          cpf.text = '';
                          getAllOrders();
                        },
                        icon: Icon(Icons.clear));
                  }

                  return IconButton(
                      onPressed: () {
                        getAllCPFOrders();
                      },
                      icon: Icon(Icons.search));
                }(),
              ],
            ),
          ),
          Expanded(
            child: CupertinoListView.builder(
              padding: new EdgeInsets.all(20.0),
              sectionCount: 1,
              itemInSectionCount: (section) => orders.length,
              sectionBuilder: _buildSection,
              childBuilder: _buildItem,
              separatorBuilder: _buildSeparator,
              controller: _scrollController,
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => CreateOrderPage()))
                .then((value) => getAllOrders());
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
              child: ListTile(
                title: Text('#' +
                    orders[index.child].id.toString() +
                    ' - ' +
                    orders[index.child].client!.name! +
                    ' ' +
                    orders[index.child].client!.lastName!),
                subtitle: Text(DateFormat('dd/MM/yyyy HH:mm')
                    .format(orders[index.child].date!)),
              ),
              width: 300.0),
          Spacer(),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 'view', child: Text('Visualizar')),
                PopupMenuItem(value: 'delete', child: Text('Remover'))
              ];
            },
            onSelected: (String value) {
              if (value == 'view') {
                Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ListDetailOrderPage(
                                order: orders[index.child])))
                    .then((value) => getAllOrders());
              }
              if (value == 'delete') deleteOrder(orders[index.child]);
            },
          )
        ],
      ),
    );
  }

  Future getAllOrders() async {
    final ordersFromRepository = await orderRepository.getAll();
    setState(() {
      orders = ordersFromRepository;
      _filteredByCpf = false;
    });
  }

  Future getAllCPFOrders() async {
    var cpfNumber = UtilBrasilFields.removeCaracteres(cpf.text);

    if (!isValidCpf(cpfNumber)) {
      return;
    }

    final ordersFromRepository = await orderRepository.getAllByCpf(cpfNumber);
    setState(() {
      orders = ordersFromRepository;
      _filteredByCpf = true;
    });
  }

  bool isValidCpf(cpfNumber) {
    if (!UtilBrasilFields.isCPFValido(cpfNumber)) {
      setCpfError('O CPF informado é inválido.');
      return false;
    }

    setCpfError(null);
    return true;
  }

  void setCpfError(String? errorMessage) {
    setState(() {
      _errorCpf = errorMessage;
    });
  }

  Future<void> deleteOrder(Order orderId) async {
    await orderRepository.delete(orderId);

    await getAllOrders();
  }
}

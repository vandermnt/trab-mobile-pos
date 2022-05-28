import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trab_mobile_pos/model/client.dart';
import 'package:trab_mobile_pos/model/order.dart';
import 'package:trab_mobile_pos/model/order_item.dart';
import 'package:trab_mobile_pos/model/product.dart';
import 'package:trab_mobile_pos/repositories/client/client_repository.dart';
import 'package:trab_mobile_pos/repositories/order/order_repository.dart';
import 'package:trab_mobile_pos/repositories/product/product_repository.dart';

class CreateOrderPage extends StatefulWidget {
  CreateOrderPage({Key? key}) : super(key: key);

  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  List<Product> products = [];

  final _formKey = GlobalKey<FormState>();
  final ProductRepository productRepository = ProductRepository();
  final ClientRepository clientRepository = ClientRepository();

  final TextEditingController cpf = TextEditingController();
  final TextEditingController quantity = TextEditingController();

  Client? selectedClient;
  Product? selectedProduct;

  String? _errorCpf;

  List<OrderItem> orderItems = [];

  @override
  void initState() {
    super.initState();
    this.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Novo Pedido")),
        body: SafeArea(
          child: Container(
              margin: new EdgeInsets.all(25),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: (() {
                        if (selectedClient == null) {
                          return Focus(
                            child: TextFormField(
                              controller: cpf,
                              decoration: new InputDecoration(
                                  hintText: 'CPF do Cliente',
                                  errorText: _errorCpf),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter(),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setCpfError('Selecione um cliente.');
                                  return _errorCpf;
                                }

                                if (!UtilBrasilFields.isCPFValido(value)) {
                                  setCpfError('O CPF informado não é válido.');
                                  return _errorCpf;
                                }

                                setCpfError(null);
                                return _errorCpf;
                              },
                              keyboardType: TextInputType.number,
                            ),
                            onFocusChange: (hasFocus) {
                              if (!hasFocus) {
                                getClient();
                              }
                            },
                          );
                        }

                        return Row(children: [
                          Expanded(
                              child: ListTile(
                            leading: Icon(
                              Icons.person,
                              size: 40,
                            ),
                            style: ListTileStyle.drawer,
                            title: Text(
                              selectedClient!.name! +
                                  ' ' +
                                  selectedClient!.lastName!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('CPF: ' +
                                UtilBrasilFields.obterCpf(
                                    selectedClient!.cpf!)),
                          )),
                          IconButton(
                              onPressed: () {
                                setSelectedClient(null);
                              },
                              icon: Icon(Icons.change_circle))
                        ]);
                      }()),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffe2f1fc),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Column(
                        children: [
                          DropdownButton<Product>(
                            value: selectedProduct,
                            itemHeight: 50.0,
                            isExpanded: true,
                            hint: Text('Selecione um Produto'),
                            items: products.map<DropdownMenuItem<Product>>(
                                (Product product) {
                              return DropdownMenuItem<Product>(
                                value: product,
                                child: Text(product.description!),
                              );
                            }).toList(),
                            onChanged: (product) => setSelectedProduct(product),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: TextFormField(
                                  controller: quantity,
                                  decoration: new InputDecoration(
                                      hintText: 'Quantidade',
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      )),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Spacer(flex: 1),
                              Expanded(
                                  flex: 6,
                                  child: OutlinedButton(
                                    child: Text('Adicionar'),
                                    onPressed: () => addNewOrderItem(),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: <Widget>[
                      Expanded(child: Divider()),
                      Text(
                        "    Itens do Pedido:    ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Expanded(child: Divider()),
                    ]),
                    Expanded(
                        flex: 1,
                        child: ListView(
                          children: orderItems.map((orderItem) {
                            return Row(children: [
                              Expanded(
                                  child: ListTile(
                                title: Text(orderItem.product!.description!),
                                subtitle: Text(
                                    orderItem.quantity.toString() + ' un.'),
                                style: ListTileStyle.drawer,
                              )),
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                color: Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    orderItems.removeAt(
                                        orderItems.indexOf(orderItem));
                                  });
                                },
                              )
                            ]);
                          }).toList(),
                        )),
                    MaterialButton(
                      minWidth: double.maxFinite,
                      color: Colors.green,
                      onPressed: () => _save(),
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    )
                  ]))),
        ));
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedClient == null) {
      showSnackBarMessage('É necessário selecionar um cliente.');
      return;
    }

    if (orderItems.length == 0) {
      showSnackBarMessage('É necessário adicionar ao menos 1 item.');
      return;
    }

    Order order = Order.novo(DateTime.now(), selectedClient!, orderItems);
    await OrderRepository().create(order);

    showSnackBarMessage('Pedido criado com sucesso!');
    _returnToPageList();
  }

  void _returnToPageList() {
    Navigator.pop(context);
  }

  Future getAllProducts() async {
    final productsFromRepository = await productRepository.getAll();

    setState(() {
      products = productsFromRepository;
    });
  }

  Future getClient() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var numeroCpf = UtilBrasilFields.removeCaracteres(cpf.text);

    try {
      final client = await clientRepository.getClientByCpf(numeroCpf);
      setSelectedClient(client);
    } catch (e) {
      setCpfError('Cliente não está cadastrado.');
    }
  }

  void setSelectedClient(Client? client) {
    setState(() {
      selectedClient = client;
    });
  }

  void setSelectedProduct(Product? product) {
    setState(() {
      selectedProduct = product;
    });
  }

  void setCpfError(String? errorMessage) {
    setState(() {
      _errorCpf = errorMessage;
    });
  }

  void addNewOrderItem() {
    if (selectedProduct == null) {
      showSnackBarMessage('Selecione um produto!');
      return;
    }

    var orderItem = OrderItem.novo(selectedProduct!, int.parse(quantity.text));
    orderItems.add(orderItem);

    clearProductFields();
  }

  void clearProductFields() {
    setSelectedProduct(null);
    quantity.clear();
  }

  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.fixed, content: Text(message)));
  }
}

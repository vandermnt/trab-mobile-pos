import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trab_mobile_pos/model/product.dart';
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

  final TextEditingController description = TextEditingController();

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  @override
  void initState() {
    super.initState();
    this.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Pedido")),
      body: Container(
          margin: new EdgeInsets.all(30.0), // Or set whatever you want
          child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  controller: description,
                  decoration: new InputDecoration(hintText: 'Descrição'),
                  maxLength: 70,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo não pode ser vazio!';
                    }
                    return null;
                  },
                ),
              ]))),
    );
  }

  void _save() async {
    //
  }

  Future getAllProducts() async {
    final productsFromRepository = await productRepository.getAll();
    setState(() {
      products = productsFromRepository;
    });
  }
}

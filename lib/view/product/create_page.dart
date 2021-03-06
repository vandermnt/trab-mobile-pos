import 'package:flutter/material.dart';
import 'package:trab_mobile_pos/model/product.dart';
import 'package:trab_mobile_pos/repositories/product/product_repository.dart';

class CreateProductPage extends StatefulWidget {
  CreateProductPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Produtos")),
      body: Container(
          margin: new EdgeInsets.all(30.0), // Or set whatever you want
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                SizedBox(height: 10),
                MaterialButton(
                  minWidth: double.maxFinite, // set minWidth to maxFinite
                  color: Colors.green,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _save();
                    }
                  },
                  child: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _save() async {
    Product newProduct = Product.novo(description.text);
    await ProductRepository().create(newProduct);

    _returnToPageList();
  }

  void _returnToPageList() {
    Navigator.pop(context);
  }
}

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trab_mobile_pos/model/product.dart';
import 'package:trab_mobile_pos/repositories/client/client_repository.dart';
import 'package:trab_mobile_pos/repositories/product/product_repository.dart';

class EditPage extends StatefulWidget {
  late Product product;

  EditPage({Key? key, required this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _description;

  @override
  initState() {
    this._description = TextEditingController(text: widget.product.description);
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.black87,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Produto")),
      body: Container(
          margin: new EdgeInsets.all(30.0), // Or set whatever you want
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: this._description,
                  decoration: new InputDecoration(hintText: 'Descrição'),
                  maxLength: 40,
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
                )
              ],
            ),
          )),
    );
  }

  void _save() async {
    this.widget.product.description = this._description.text;

    await ProductRepository().update(this.widget.product);

    _returnToPageList();
  }

  void _returnToPageList() {
    Navigator.pop(context);
  }
}

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trab_mobile_pos/model/client.dart';
import 'package:trab_mobile_pos/repositories/client/client_repository.dart';

class CreateClientPage extends StatefulWidget {
  CreateClientPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateClientPageState();
}

class _CreateClientPageState extends State<CreateClientPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController cpf = TextEditingController();
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
      appBar: AppBar(title: Text("Cadastrar Clientes")),
      body: Container(
          margin: new EdgeInsets.all(30.0), // Or set whatever you want
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: new InputDecoration(hintText: 'Nome'),
                  maxLength: 40,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo não pode ser vazio!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lastName,
                  maxLength: 80,
                  decoration: new InputDecoration(hintText: 'Sobrenome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo não pode ser vazio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: cpf,
                  decoration: new InputDecoration(hintText: 'CPF'),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
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
    Client newClient = Client.novo(name.text, lastName.text, cpf.text);
    await ClientRepository().create(newClient);

    _returnToPageList();
  }

  void _returnToPageList() {
    Navigator.pop(context);
  }
}

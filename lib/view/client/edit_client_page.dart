import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trab_mobile_pos/model/client.dart';
import 'package:trab_mobile_pos/repositories/client/client_repository.dart';

class EditClientPage extends StatefulWidget {
  late Client client;

  EditClientPage({Key? key, required this.client}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditClientPageState();
}

class _EditClientPageState extends State<EditClientPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _lastName;
  late TextEditingController _cpf;

  @override
  initState() {
    this._name = TextEditingController(text: widget.client.name);
    this._lastName = TextEditingController(text: widget.client.lastName);
    this._cpf = TextEditingController(text: widget.client.cpf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar  Cliente")),
      body: Container(
          margin: new EdgeInsets.all(30.0), // Or set whatever you want
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: this._name,
                  decoration: new InputDecoration(hintText: 'Nome'),
                  maxLength: 40,
                ),
                TextFormField(
                  controller: this._lastName,
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
                  controller: this._cpf,
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
    var numeroCpf = UtilBrasilFields.removeCaracteres(this._cpf.text);

    this.widget.client.name = this._name.text;
    this.widget.client.lastName = this._lastName.text;
    this.widget.client.lastName = this._lastName.text;
    this.widget.client.cpf = numeroCpf;

    await ClientRepository().update(this.widget.client);

    _returnToPageList();
  }

  void _returnToPageList() {
    Navigator.pop(context);
  }
}

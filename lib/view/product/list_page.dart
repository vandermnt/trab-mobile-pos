import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:trab_mobile_pos/model/product.dart';
import 'package:trab_mobile_pos/repositories/product/product_repository.dart';

import 'create_page.dart';

class ListProductPage extends StatefulWidget {
  ListProductPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _ListProductPage();
}

class _ListProductPage extends State<ListProductPage> {
  List<Product> products = [];

  late final ScrollController _scrollController;
  final ProductRepository productRepository = ProductRepository();

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
      appBar: AppBar(title: Text("Produtos")),
      body: CupertinoListView.builder(
        padding: new EdgeInsets.all(20.0),
        sectionCount: 1,
        itemInSectionCount: (section) => products.length,
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
                CupertinoPageRoute(builder: (context) => CreateProductPage()));
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
              child: Text(products[index.child].description as String),
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
              if (value == 'edit')
                print("teste");
              else
                print("teste");
            },
          )
        ],
      ),
    );
  }

  Future getAllClients() async {
    final productsFromRepository = await productRepository.getAll();

    setState(() {
      products = productsFromRepository;
    });
  }
}

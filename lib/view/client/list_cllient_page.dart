import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:trab_mobile_pos/view/client/create_client_page.dart';

class ListClientPage extends StatefulWidget {
  ListClientPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _ListClientPage();
}

class _ListClientPage extends State<ListClientPage> {
  late final ScrollController _scrollController;

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
      appBar: AppBar(title: Text("Clientes")),
      body: CupertinoListView.builder(
        sectionCount: 50,
        itemInSectionCount: (section) => 50,
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
                CupertinoPageRoute(builder: (context) => CreateClientPage()));
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
          SizedBox(child: Text("dwadawawdaw"), width: 120.0),
          Expanded(child: Text("attribute.attribute")),
        ],
      ),
    );
  }
}

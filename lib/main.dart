import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trab_mobile_pos/view/client/list_cllient_page.dart';
import 'package:trab_mobile_pos/view/order/list_order_page.dart';
import 'package:trab_mobile_pos/view/product/list_page.dart';

void main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedidos App - Grupo 06',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Pedidos"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Clientes"),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Produtos")
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: ListOrderPage(title: "Pedidos"),
                );
              },
            );

          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: ListClientPage(
                    title: "Clientes",
                  ),
                );
              },
            );

          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: ListProductPage(
                    title: "Produtos",
                  ),
                );
              },
            );

          default:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: ListOrderPage(title: "Pedidos"),
                );
              },
            );
        }
      },
    );
  }
}

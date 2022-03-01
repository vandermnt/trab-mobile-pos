import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trab_mobile_pos/view/client/list_cllient_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CupertinoListView Demo',
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
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Clientes"),
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Produtos")
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          print(index);
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      middle: Text('Page 1 of tab $index'),
                    ),
                    child: Center(
                      child: CupertinoButton(
                        child: const Text('Next page'),
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute<void>(
                              builder: (BuildContext context) {
                                return CupertinoPageScaffold(
                                  navigationBar: CupertinoNavigationBar(
                                    middle: Text('Page 2 of tab $index'),
                                  ),
                                  child: Center(
                                    child: CupertinoButton(
                                      child: const Text('Back'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );

            default:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return CupertinoPageScaffold(
                    child: ListClientPage(
                      title: "Teste",
                    ),
                  );
                },
              );
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:meus_gastos/widgets/InsertTransactions.dart';
import 'package:meus_gastos/widgets/Charts.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Recolhe o teclado
      },
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Verde!',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: 'Azul',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return InsertTransactions(
                title: 'Adicionar Transações',
                onAddClicked: () {
                  // FocusScope.of(context).unfocus();
                },
              );
            default:
              return DashboardScreen();
          }
        },
      ),
    );
  }
}

class BlueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}

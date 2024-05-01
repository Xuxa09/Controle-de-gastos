import 'package:flutter/material.dart';
import 'package:meus_gastos/widgets/Transactions/InsertTransactions.dart';
import 'package:meus_gastos/widgets/Dashboards/Charts.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.light, // Define explicitamente o tema claro
      ),
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
              label: 'Transações',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: 'Dashboard',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return InsertTransactions(
                title: 'Adicionar Transações',
                onAddClicked: () {
                  // FocusScope.of(context). un-focus.
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

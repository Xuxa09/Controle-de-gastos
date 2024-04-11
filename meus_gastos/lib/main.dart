import 'package:flutter/material.dart';
import 'Scenes/InsertTransaction/InsertTransactions/widgets/HeaderCard.dart';
import 'Scenes/InsertTransaction/InsertTransactions/widgets/ListCard.dart';
import 'Scenes/InsertTransaction/InsertTransactions/models/CardModel.dart';
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/services/CardService.dart'
    as service;
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/InsertTransactionViewController.dart';
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/widgets/DetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/chartsViewController.dart';

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
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Verde',
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
            return InsertTransactionViewController(title: 'My Home Page');
          default:
            return ChartsViewController();
        }
      },
    );
  }
}

class GreenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Green Screen'),
      ),
      child: Container(color: Colors.green),
    );
  }
}

class BlueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}

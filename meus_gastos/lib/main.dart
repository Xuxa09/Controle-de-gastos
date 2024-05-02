import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meus_gastos/widgets/Transactions/InsertTransactions.dart';
import 'package:meus_gastos/widgets/Dashboards/DashboardScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.black38,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                size: 20,
              ),
              label: 'Transações',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.chart_bar,
                size: 20,
              ),
              label: 'Dashboard',
            ),
          ],
          onTap: (int index) {
            setState(() {
              selectedTab = index;
            });
          },
        ),
        tabBuilder: (context, index) {
          Widget content;
          switch (index) {
            case 0:
              content = InsertTransactions(
                title: 'Meus Gastos',
                onAddClicked: () {},
              );
              break;
            default:
              content = DashboardScreen(isActive: selectedTab == 1);
              break;
          }
          return content;
        },
      ),
    );
  }
}

class BlueController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Blue Controller',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

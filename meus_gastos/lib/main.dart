import 'package:flutter/cupertino.dart';
import 'package:meus_gastos/widgets/Transactions/InsertTransactions.dart';
import 'package:meus_gastos/widgets/Dashboards/Charts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
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
                title: 'Adicionar Transações',
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

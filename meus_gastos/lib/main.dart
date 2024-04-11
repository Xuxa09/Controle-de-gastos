import 'package:flutter/material.dart';
import 'Scenes/InsertTransaction/InsertTransactions/widgets/HeaderCard.dart';
import 'Scenes/InsertTransaction/InsertTransactions/widgets/ListCard.dart';
import 'Scenes/InsertTransaction/InsertTransactions/models/CardModel.dart';
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/services/CardService.dart'
    as service;
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/InsertTransactionViewController.dart';
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/widgets/DetailScreen.dart';
import 'package:flutter/cupertino.dart';

// class MyHomePage2 extends StatefulWidget {
//   const MyHomePage2({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage2> createState() => _MyHomePage2State();
// }

// class _MyHomePage2State extends State<MyHomePage2>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController _dateController = TextEditingController();
//   List<CardModel> cardList = [];
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     loadCards();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   Future<void> loadCards() async {
//     var cards = await service.CardService
//         .retrieveCards(); // Carregar os dados assíncronos
//     setState(() {
//       cardList = cards;
//     });
//   }

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _tabController.dispose();
//     super.dispose();
//   }

//   bool _showHeaderCard = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           if (_showHeaderCard) ...[
//             Padding(
//               padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
//               child: HeaderCard(
//                 adicionarButtonTitle: 'Adicionar',
//                 onAddClicked: () {
//                   setState(() {
//                     loadCards();
//                   });
//                 },
//               ),
//             ),
//           ],
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 1,
//                 width: MediaQuery.of(context).size.width - 100,
//                 color: Colors.black.withOpacity(0.2),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     _showHeaderCard = !_showHeaderCard;
//                   });
//                 },
//                 icon: Icon(
//                   _showHeaderCard ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 ListView.builder(
//                   itemCount: cardList.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 5),
//                       child: ListCard(
//                         onTap: (card) {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return Dialog(
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: DetailScreen(
//                                       card: card,
//                                       onAddClicked: () {
//                                         loadCards();
//                                         Navigator.pop(context);
//                                       }),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         card: cardList[cardList.length - index - 1],
//                       ),
//                     );
//                   },
//                 ),
//                 Container(
//                   color: Colors.blue,
//                   child: Center(
//                     child: Text(
//                       'Tab 2',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
            return GreenScreen();
          case 1:
            return InsertTransactionViewController(title: 'My Home Page');
          default:
            return GreenScreen();
        }
      },
    );
  }
}

class GreenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
  }
}

class BlueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}

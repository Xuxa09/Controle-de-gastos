import 'package:flutter/material.dart';
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/widgets/HeaderCard.dart';
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/widgets/ListCard.dart';
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/models/CardModel.dart';
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/services/CardService.dart'
    as service;
import 'package:meus_gastos/Scenes/InsertTransaction/InsertTransactions/widgets/DetailScreen.dart';
import 'package:flutter/cupertino.dart';

class InsertTransactionViewController extends StatefulWidget {
  const InsertTransactionViewController({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<InsertTransactionViewController> createState() =>
      _InsertTransactionViewControllerState();
}

class _InsertTransactionViewControllerState
    extends State<InsertTransactionViewController>
    with SingleTickerProviderStateMixin {
  final TextEditingController _dateController = TextEditingController();
  List<CardModel> cardList = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    loadCards();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> loadCards() async {
    var cards = await service.CardService
        .retrieveCards(); // Carregar os dados assíncronos
    setState(() {
      cardList = cards;
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  bool _showHeaderCard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CupertinoNavigationBar(
            middle: Text(widget.title),
          ),
          if (_showHeaderCard) ...[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: HeaderCard(
                adicionarButtonTitle: 'Adicionar',
                onAddClicked: () {
                  setState(() {
                    loadCards();
                  });
                },
              ),
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width - 100,
                color: Colors.black.withOpacity(0.2),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _showHeaderCard = !_showHeaderCard;
                  });
                },
                icon: Icon(
                  _showHeaderCard ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: cardList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListCard(
                        onTap: (card) {
                          print("aqui!!!");
                          _showCupertinoModalBottomSheet(context, card);
                        },
                        card: cardList[cardList.length - index - 1],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCupertinoModalBottomSheet(BuildContext context, CardModel card) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: DetailScreen(
            card: card,
            onAddClicked: () {
              loadCards();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'widgets/HeaderCard.dart';
import 'widgets/ListCard.dart';
import 'models/CardModel.dart';
import 'package:meus_gastos/services/CardService.dart' as service;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Controle de gastos'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _dateController = TextEditingController();
  List<CardModel> cardList = [];

  @override
  void initState() {
    super.initState();
    loadCards();
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
    super.dispose();
  }

  bool _showHeaderCard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          if (_showHeaderCard) ...[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: HeaderCard(
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
            child: ListView.builder(
              itemCount: cardList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListCard(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: DetailScreen(card: cardList.first),
                          );
                        },
                      );
                    },
                    card: cardList[cardList.length - index - 1],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final CardModel card;

  const DetailScreen({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Faz com que o conteúdo dicte o tamanho do modal
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detalhes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Lógica para excluir o cartão
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          HeaderCard(
            onAddClicked: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/HeaderCard.dart';
import 'widgets/ListCard.dart';
import 'models/CardModel.dart';
import 'services/CardService.dart';
import 'package:meus_gastos/services/CardService.dart';
import 'package:meus_gastos/services/CardService.dart' as service;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Esconder o teclado quando houver clique na tela
        FocusScope.of(context).unfocus();
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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _dateController = TextEditingController();
  List<CardModel> cardList =
      []; // Certifique-se de que a lista esteja inicializada

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  void loadCards() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: Column(
          children: [
            HeaderCard(
              onAddClicked: () {
                setState(() {
                  loadCards();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cardList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListCard(
                      card: cardList[cardList.length - index - 1],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

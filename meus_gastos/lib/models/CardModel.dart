import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CardModel {
  final String amount;
  final String description;
  final DateTime date;

  CardModel({
    required this.amount,
    required this.description,
    required this.date,
  });

  // Método para converter um objeto CardModel em um mapa
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  // Método para criar um objeto CardModel a partir de um mapa
  factory CardModel.fromJson(Map<String, dynamic> map) {
    return CardModel(
      amount: map['amount'],
      description: map['description'],
      date: DateTime.parse(map['date']),
    );
  }
}

class CardService {
  static const String _storageKey = 'cardModels';

  // Método para recuperar o array de elementos salvos
  static Future<List<CardModel>> retrieveCards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cardsString = prefs.getString(_storageKey);
    if (cardsString != null) {
      final List<dynamic> jsonList = json.decode(cardsString);
      final List<CardModel> cards =
          jsonList.map((jsonItem) => CardModel.fromJson(jsonItem)).toList();
      return cards;
    } else {
      return [];
    }
  }

  // Método para adicionar um novo elemento ao array salvo
  static Future<void> addCard(CardModel cardModel) async {
    final List<CardModel> cards = await retrieveCards();
    cards.add(cardModel);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData =
        json.encode(cards.map((card) => card.toJson()).toList());
    await prefs.setString(_storageKey, encodedData);
  }

  // Método para deletar todos os elementos do array salvo
  static Future<void> deleteAllCards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  // Método para imprimir todos os elementos salvos
  static Future<void> printAllCards() async {
    final List<CardModel> cards = await retrieveCards();
    if (cards.isNotEmpty) {
      for (var card in cards) {
        print(
            'Amount: ${card.amount}, Description: ${card.description}, Date: ${card.date}');
      }
    } else {
      print('Não há elementos salvos.');
    }
  }
}

List<CardModel> cardList = [
  CardModel(
      amount: 'R\$ 10,00',
      description: 'Compras da semana no mercado',
      date: DateTime.now()),
  CardModel(
      amount: 'R\$ 20,00',
      description: 'Pagamento de contas',
      date: DateTime.now()),
  CardModel(
      amount: 'R\$ 15,00',
      description: 'Cinema com amigos',
      date: DateTime.now()),
  CardModel(
      amount: 'R\$ 12,00',
      description: 'Lanche na cafeteria',
      date: DateTime.now()),
  CardModel(
      amount: 'R\$ 8,00',
      description: 'Transporte público',
      date: DateTime.now()),
];

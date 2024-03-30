import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meus_gastos/models/CardModel.dart';

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

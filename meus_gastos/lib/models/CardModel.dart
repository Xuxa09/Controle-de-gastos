import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CardModel {
  final String amount;
  final String description;
  final DateTime date;
  final String category;

  CardModel({
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'category': category,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> map) {
    return CardModel(
      amount: map['amount'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      category: map['category'],
    );
  }
}

class CardService {
  static const String _storageKey = 'cardModels';

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

  static Future<void> addCard(CardModel cardModel) async {
    final List<CardModel> cards = await retrieveCards();
    cards.add(cardModel);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData =
        json.encode(cards.map((card) => card.toJson()).toList());
    await prefs.setString(_storageKey, encodedData);
  }

  static Future<void> deleteAllCards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

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

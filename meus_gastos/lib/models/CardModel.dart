import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CardModel {
  final String id; // New property

  final String amount;
  final String description;
  final DateTime date;
  final String category;

  CardModel({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'category': category,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      amount: map['amount'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      category: map['category'],
    );
  }
}

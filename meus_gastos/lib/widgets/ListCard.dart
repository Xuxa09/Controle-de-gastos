import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meus_gastos/models/CardModel.dart';
import 'package:intl/intl.dart';
import 'package:meus_gastos/widgets/HorizontalCircleList.dart';

class ListCard extends StatelessWidget {
  final CardModel card;
  final Function(CardModel) onTap; // Updated function signature

  ListCard({required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(card), // Pass card as a parameter
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatCurrency(card.amount),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    getIconByCategory(
                      getCategoryByName(
                        card.category.replaceAll("Category.", ""),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              card.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 2),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat('HH:mm dd/MM/yyyy').format(card.date),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatCurrency(double value) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatter.format(value);
  }
}

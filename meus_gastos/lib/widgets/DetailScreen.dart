import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:meus_gastos/models/CardModel.dart';
import 'package:meus_gastos/services/CardService.dart';
import 'CampoComMascara.dart';
import 'HorizontalCircleList.dart';
import 'ValorTextField.dart';
import 'EditionHeaderCard.dart';
import 'package:meus_gastos/services/CardService.dart' as service;

class DetailScreen extends StatelessWidget {
  final CardModel card;
  final VoidCallback onAddClicked;

  const DetailScreen({required this.onAddClicked, Key? key, required this.card})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detalhes da transação',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    CardService.deleteCard(card.id);
                    Future.delayed(Duration(milliseconds: 300), () {
                      onAddClicked();
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          EditionHeaderCard(
            card: card,
            adicionarButtonTitle: 'Atualizar',
            onAddClicked: () {
              onAddClicked();
            },
          ),
        ],
      ),
    );
  }
}

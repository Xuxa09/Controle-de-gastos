import 'package:flutter/material.dart';
// import 'package:meus_gastos/widgets/HeaderCard.dart';
import 'package:meus_gastos/widgets/ListCard.dart';
import 'package:meus_gastos/models/CardModel.dart';
import 'package:meus_gastos/services/CardService.dart' as service;
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'CampoComMascara.dart';
import 'HorizontalCircleList.dart';
import 'package:meus_gastos/models/CardModel.dart';
import 'ValorTextField.dart';
import 'package:meus_gastos/services/CardService.dart';

class DetailScreen extends StatelessWidget {
  final CardModel card;

  const DetailScreen({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
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
                  'Detalhes da transação',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
            onAddClicked: () {},
          ),
        ],
      ),
    );
  }
}

class EditionHeaderCard extends StatefulWidget {
  final VoidCallback onAddClicked; // Delegate to notify the parent view
  final String adicionarButtonTitle; // Parameter to initialize the class
  final CardModel card;
  EditionHeaderCard(
      {required this.onAddClicked,
      required this.adicionarButtonTitle,
      required this.card});

  @override
  _EditionHeaderCardState createState() => _EditionHeaderCardState();
}

class _EditionHeaderCardState extends State<EditionHeaderCard> {
  late TextEditingController descricaoController;
  late MoneyMaskedTextController valorController;
  late CampoComMascara dateController;

  @override
  void initState() {
    super.initState();
    descricaoController = TextEditingController(text: widget.card.description);
    valorController = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
      decimalSeparator: ',',
      initialValue: double.parse(widget.card.amount
          .replaceAll('R\$ ', "")
          .replaceAll(',', "")), // Use widget.card.amount as initial value
    );
    DateTime date = widget.card.date;
    String formattedDate =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().substring(2)} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    dateController = CampoComMascara(dateText: formattedDate);
  }

  int lastIndexSelected = 0;
  final DateTime dataInicial =
      DateTime.now(); // Use widget.card.date as initial value
  final double valorInicial = 0.0; // Valor inicial

  void adicionar() {
    FocusScope.of(context).unfocus();
    final valor = valorController.numberValue;
    final descricao = descricaoController.text;

    final newCard = CardModel(
        amount: valorController.text,
        description: descricaoController.text,
        date: DateTime.now(), // Utiliza a data inicial
        category: Category.values[lastIndexSelected].toString(),
        id: CardService.generateUniqueId());
    CardService.addCard(newCard);

    Future.delayed(Duration(milliseconds: 300), () {
      widget.onAddClicked();
    });
  }

  @override
  void dispose() {
    valorController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: ValorTextField(controller: valorController)),
              SizedBox(width: 8),
              Expanded(
                child: dateController,
              ),
            ],
          ),
          SizedBox(height: 8),
          CupertinoTextField(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors
                      .systemGrey5, // Change the color of the bottom line
                ),
              ),
            ),
            placeholder: 'Descrição',
            controller: descricaoController,
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.zero,
            child: HorizontalCircleList(
              onItemSelected: (index) {
                setState(() {
                  lastIndexSelected = index; // Save the last selected index
                });
              },
            ),
          ),
          SizedBox(height: 26),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CupertinoButton(
              color: CupertinoColors.systemGreen.darkHighContrastElevatedColor,
              onPressed: adicionar,
              child: Text(
                widget.adicionarButtonTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

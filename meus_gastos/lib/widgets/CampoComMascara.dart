import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CampoComMascara extends StatefulWidget {
  @override
  _CampoComMascaraState createState() => _CampoComMascaraState();
}

class _CampoComMascaraState extends State<CampoComMascara> {
  // Criando um MaskedTextController
  final _dateController = MaskedTextController(mask: '00/00/00 00:00');

  @override
  void initState() {
    super.initState();
    _dateController.text = _getCurrentDate();
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString().substring(2)} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _dateController,
      keyboardType:
          TextInputType.number, // Define o tipo de teclado como numérico
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: CupertinoColors.systemGrey5)),
      ),
      placeholder: 'DD/MM/AA HH:mm',
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter/services.dart';

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

  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _dateController,
      focusNode: _focusNode,
      onTap: () {
        _focusNode.unfocus();
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 300,
              color:
                  CupertinoColors.white, // Definindo o background branco opaco
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    _dateController.text = _formatDateTime(newDateTime);
                  });
                },
              ),
            );
          },
        );
      },
      keyboardType: TextInputType.number, // Definindo o teclado como numérico
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: CupertinoColors.systemGrey5)),
      ),
      placeholder: 'DD/MM/AA HH:mm',
    );
  }

  String _formatDateTime(DateTime dateTime) {
    String formattedDate =
        '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(2)} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return formattedDate;
  }
}

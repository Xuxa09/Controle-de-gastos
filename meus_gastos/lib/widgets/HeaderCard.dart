import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter/material.dart';
import 'CampoComMascara.dart';
import 'HorizontalCircleList.dart';

class HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final valorController = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
      decimalSeparator: ',',
    );
    final descricaoController = TextEditingController();

    void adicionar() {
      final valor = valorController.numberValue;
      final descricao = descricaoController.text;

      print('Valor: \$valor');
      print('Descrição: \$descricao');
      print('Data selecionada: ${DateTime.now()}');
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Esconde o teclado ao clicar na tela
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: CupertinoColors
                              .systemGrey5, // Altera a cor da linha inferior
                        ),
                      ),
                    ),
                    placeholder: 'Valor',
                    prefix: Text('R\$ '),
                    keyboardType: TextInputType.number,
                    controller: valorController,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: CampoComMascara(),
                ),
              ],
            ),
            SizedBox(height: 8),
            CupertinoTextField(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors
                        .systemGrey5, // Altera a cor da linha inferior
                  ),
                ),
              ),
              placeholder: 'Descrição',
              controller: descricaoController,
            ),
            SizedBox(height: 16),
            HorizontalCircleList(
              itemCount: 4,
              onItemSelected: (index) {
                print('Índice selecionado: \$index');
              },
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CupertinoButton(
                color: CupertinoColors.systemGreen,
                onPressed: adicionar,
                child: Text('Adicionar'),
              ),
            ),
            SizedBox(height: 24),
            Divider(
              height:
                  1, // Altura total do divisor, incluindo espaço antes e depois.
              thickness: 1, // A grossura da linha do divisor.
              color: CupertinoColors.black, // Cor do divisor.
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

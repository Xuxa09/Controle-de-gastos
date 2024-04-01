import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CustomButton.dart';

class ValorTextField extends StatefulWidget {
  final MoneyMaskedTextController controller;

  ValorTextField({required this.controller});

  @override
  _ValorTextFieldState createState() => _ValorTextFieldState();
}

class _ValorTextFieldState extends State<ValorTextField> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      print("aqui2");
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
    } else {
      print("aqui1");
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final screenWidth =
        MediaQuery.of(context).size.width; // Obter a largura da tela

    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 0, // Use 0 para alinhar à esquerda da tela
        width: screenWidth, // Use a largura da tela
        child: KeyboardAccessory(
          onDone: () {
            _focusNode.unfocus();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      focusNode: _focusNode,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey5,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: widget.controller,
    );
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }
}

class KeyboardAccessory extends StatelessWidget {
  final VoidCallback onDone;

  const KeyboardAccessory({Key? key, required this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      padding: EdgeInsets.only(right: 10.0),
      height: 80, // Defina uma altura adequada para o container
      child: ListView(
        scrollDirection:
            Axis.horizontal, // Define a direção da rolagem como horizontal
        children: <Widget>[
          CustomButton(
            text: '+10',
            onPressed: onDone,
          ),
          CustomButton(
            text: '+20',
            onPressed: onDone,
          ),
          CustomButton(
            text: '+30',
            onPressed: onDone,
          ),
          CustomButton(
            text: '+50',
            onPressed: onDone,
          ),
          CustomButton(
            text: '+80',
            onPressed: onDone,
          ),
          CustomButton(
            text: '+100',
            onPressed: onDone,
          ),
        ],
      ),
    );
  }
}

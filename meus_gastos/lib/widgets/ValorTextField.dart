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
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final screenWidth = MediaQuery.of(context).size.width;

    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 0,
        width: screenWidth,
        child: KeyboardAccessory(
          onDone: (int value) {
            widget.controller.updateValue(
              widget.controller.numberValue + value,
            );
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
  final ValueChanged<int> onDone;

  const KeyboardAccessory({Key? key, required this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var value in [10, 20, 30, 50, 80, 100])
            CustomButton(
              text: '+$value',
              onPressed: () => onDone(value),
            ),
        ],
      ),
    );
  }
}

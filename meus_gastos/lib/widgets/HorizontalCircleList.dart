import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter/material.dart';
import 'CampoComMascara.dart';

class HorizontalCircleList extends StatefulWidget {
  final int itemCount;
  final Function(int) onItemSelected;

  const HorizontalCircleList({
    Key? key,
    required this.itemCount,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _HorizontalCircleListState createState() => _HorizontalCircleListState();
}

class _HorizontalCircleListState extends State<HorizontalCircleList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Altura suficiente para conter o círculo e algum padding
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.itemCount,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onItemSelected(index);
            },
            child: Container(
              width:
                  50, // Largura suficiente para conter o círculo e algum padding
              height: 50, // Altura para manter o aspecto do círculo
              margin: const EdgeInsets.symmetric(
                  horizontal: 8), // Espaçamento entre os círculos
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Colors.green
                    : Colors.blue, // Cor do círculo
                shape: BoxShape.circle, // Faz o container ser um círculo
              ),
            ),
          );
        },
      ),
    );
  }
}

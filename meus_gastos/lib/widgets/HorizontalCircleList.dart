import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter/material.dart';
import 'CampoComMascara.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Category {
  Unknown,
  Shopping,
  Restaurant,
  GasStation,
  Home,
  ShoppingBasket,
  Hospital,
  Volleyball,
  Movie,
  MusicNote,
  VideoGame,
  Drink
}

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
  int lastSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Category.values.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                lastSelectedIndex =
                    selectedIndex; // Save the index of the last selected button
                selectedIndex = index;
              });
              widget.onItemSelected(index);
            },
            child: Container(
              width: 50,
              height: 50, // Altura para manter o aspecto do círculo
              margin: const EdgeInsets.symmetric(
                  horizontal: 8), // Espaçamento entre os círculos
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Colors.green.withOpacity(0.3)
                    : Colors.black.withOpacity(
                        0.1), // Altera a cor do círculo selecionado
                shape: BoxShape.circle, // Faz o container ser um círculo
              ),
              child: Icon(
                getIconByCategory(Category
                    .values[index]), // Adiciona um ícone dentro do círculo
              ),
            ),
          );
        },
      ),
    );
  }
}

String getCategoryNameByIndex(int index) {
  switch (Category.values[index]) {
    case Category.Shopping:
      return 'Shopping';
    case Category.Restaurant:
      return 'Restaurant';
    case Category.GasStation:
      return 'GasStation';
    case Category.Home:
      return 'Home';
    case Category.ShoppingBasket:
      return 'ShoppingBasket';
    case Category.Hospital:
      return 'Hospital';
    case Category.Volleyball:
      return 'Volleyball';
    case Category.Movie:
      return 'Movie';
    case Category.MusicNote:
      return 'MusicNote';
    case Category.VideoGame:
      return 'VideoGame';
    case Category.Drink:
      return 'Drink';
    default:
      return 'Unknown';
  }
}

Category getCategoryByName(String name) {
  switch (name) {
    case 'Shopping':
      return Category.Shopping;
    case 'Restaurant':
      return Category.Restaurant;
    case 'GasStation':
      return Category.GasStation;
    case 'Home':
      return Category.Home;
    case 'ShoppingBasket':
      return Category.ShoppingBasket;
    case 'Hospital':
      return Category.Hospital;
    case 'Volleyball':
      return Category.Volleyball;
    case 'Movie':
      return Category.Movie;
    case 'MusicNote':
      return Category.MusicNote;
    case 'VideoGame':
      return Category.VideoGame;
    case 'Drink':
      return Category.Drink;
    default:
      return Category.Unknown;
  }
}

IconData getIconByCategory(Category category) {
  switch (category) {
    case Category.Shopping:
      return Icons.shopping_cart;
    case Category.Restaurant:
      return Icons.restaurant;
    case Category.GasStation:
      return Icons.local_gas_station;
    case Category.Home:
      return Icons.home;
    case Category.ShoppingBasket:
      return Icons.shopping_basket;
    case Category.Hospital:
      return Icons.local_hospital;
    case Category.Volleyball:
      return Icons.sports_volleyball;
    case Category.Movie:
      return Icons.movie;
    case Category.MusicNote:
      return Icons.music_note;
    case Category.VideoGame:
      return Icons.videogame_asset;
    case Category.Drink:
      return Icons.local_drink;
    default:
      return Icons.question_mark_rounded;
  }
}

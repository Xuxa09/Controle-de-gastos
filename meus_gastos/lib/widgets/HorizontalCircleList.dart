import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter/material.dart';
import 'CampoComMascara.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Category {
  Unknown, // sem categoria
  Shopping, // mercado
  Restaurant, // alimentação
  GasStation, // carro
  Home, // moradia
  ShoppingBasket, // compras
  Hospital, // Saúde
  Cigarrinho, // Cigarrinho
  Movie, // idas ao shopping
  MusicNote, // strimings
  VideoGame, // aplicativos
  Drink // roles
}

String getCategoryNameByEnum(Category category) {
  switch (category) {
    case Category.Unknown:
      return 'Sem categoria';
    case Category.Shopping:
      return 'Mercado';
    case Category.Restaurant:
      return 'Alimentação';
    case Category.GasStation:
      return 'Transporte';
    case Category.Home:
      return 'Moradia';
    case Category.ShoppingBasket:
      return 'Compras';
    case Category.Hospital:
      return 'Saúde';
    case Category.Cigarrinho:
      return 'Cigarrinho';
    case Category.Movie:
      return 'Streaming';
    case Category.MusicNote:
      return 'Gambit';
    case Category.VideoGame:
      return 'Games';
    case Category.Drink:
      return 'Bebidas';
    default:
      return '';
  }
}

class HorizontalCircleList extends StatefulWidget {
  final Function(int) onItemSelected;

  const HorizontalCircleList({
    Key? key,
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
      height: 100, // Ajuste a altura para acomodar o círculo e o texto
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Category.values.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                lastSelectedIndex = selectedIndex;
                selectedIndex = index;
              });
              widget.onItemSelected(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Para evitar preencher todo o espaço vertical
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Colors.green.withOpacity(0.3)
                        : Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    getIconByCategory(Category.values[index]),
                  ),
                ),
                SizedBox(height: 4), // Espaço entre o ícone e o texto
                Text(
                  getCategoryNameByEnum(Category.values[
                      index]), // Use a função correta para obter o nome da categoria
                  style: TextStyle(
                    fontSize: 9, // Ajuste conforme necessário
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
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
    case Category.Cigarrinho:
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
      return Category.Cigarrinho;
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
    case Category.Cigarrinho:
      return Icons.smoking_rooms;
    case Category.Movie:
      return Icons.movie;
    case Category.MusicNote:
      return Icons.music_note;
    case Category.VideoGame:
      return Icons.videogame_asset;
    case Category.Drink:
      return Icons.local_drink_outlined;
    default:
      return Icons.question_mark_rounded;
  }
}

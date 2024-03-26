import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/HeaderCard.dart';
import 'widgets/ListCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Esconder o teclado quando houver clique na tela
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Controle de gastos'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa o controlador com a data e hora atual
    _dateController.text = DateFormat('dd/MM/yy HH:mm').format(DateTime.now());
  }

  @override
  void dispose() {
    // Lembre-se de limpar o controlador quando o Widget for desmontado
    _dateController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            HeaderCard(),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListCard(),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

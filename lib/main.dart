import 'package:flutter/material.dart';

import 'myhomepage.dart';
import 'connexion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeu de Dames',
      //moyen d'effacer la banderole qui se trouvais en haut à droite
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Menu'),
      routes: <String, WidgetBuilder>{
        '/route1': (BuildContext context) => MyHomePage(title: ''),
        '/route2': (BuildContext context) => ConnectPage(title: ''),
        //'/route3': (BuildContext context) => InscriptPage(title: ''),
      },
    );
  }
}

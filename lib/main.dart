import 'package:flutter/material.dart';
import 'Vue/myhomepage.dart';
import 'Vue/connexion.dart';
import 'Vue/inscription.dart';
import 'Vue/profil.dart';
import 'VUe/classement.dart';
import 'Vue/menujeux.dart';
import 'Controller/Dames/dames.dart';
import 'Controller/Dames/regle.dart';
import 'Controller/Pendu/pendu.dart';

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
        '/route3': (BuildContext context) => InscriptPage(title: ''),
        '/route4': (BuildContext context) => Profil(title: ''),
        '/route5': (BuildContext context) => Classement(title: ''),
        '/menujeux': (BuildContext context) => MenuJeux(title: ''),
        '/dames': (BuildContext context) => Dames(title: ''),
        '/reglesdames': (BuildContext context) => Regle(title: ''),
        '/pendu': (BuildContext context) => Pendu(title: ''),
      },
    );
  }
}

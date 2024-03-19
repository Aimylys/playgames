import 'dart:async';
import '../class/pendu.dart';
import '../class/partie.dart';
import 'package:flutter/material.dart';
import '../../Vue/connexion.dart';

class Pendu extends StatefulWidget {
  const Pendu({super.key, required this.title});

  final String title;

  @override
  State<Pendu> createState() => _Pendu();
}

class _Pendu extends State<Pendu> {

  String _selectLettre = ''; // État pour stocker la lettre sélectionnée
  Plateau _plateau = new Plateau();
  Partie partie = new Partie();

  @override
  void initState() {
    gameInitialize();
    super.initState();
  }

  //initialise le plateau à son état d'origine
  void gameInitialize(){
    _plateau.inittab();
    _plateau.getPlateau();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Center(
              child: DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.brown),
                ),
              ),
            ),
            Center(
              child: ListTile(
                title: const Text(
                  'Retour au menu',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.brown),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/menujeux');
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 950,
          width: 950,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://img.freepik.com/photos-gratuite/fond-texture-bois-lisse-marron_53876-100273.jpg?w=1380&t=st=1700042662~exp=1700043262~hmac=b78a03792087927e4bd1d2952f81c7921ac69be01023148d4256174ee03b0f55"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
                width: 200,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              _headerText(),
              const SizedBox(height: 20),
              Text(
                'Lettre sélectionnée : $_selectLettre', // Afficher la lettre sélectionnée
                style: TextStyle(fontSize: 20),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              _gameContainer(),
              const Padding(padding: EdgeInsets.all(10)),
              _restartButton(),
            ],
          ),
        ),
      ),
    );
  }

  //phrase haut du tableau
  Widget _headerText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Jeu du Pendu",
          style: TextStyle(fontSize: 30.0),
        ),
      ],
    );
  }
  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 13, // 13 cases dans chaque ligne
        ),
        itemCount: 26, // 2 lignes avec 13 cases chacune
        itemBuilder: (context, index) {
          return _box(index);
        },
      ),
    );
  }

  Widget _box(int index) {
    final int row = index ~/ 13; // Calculer la ligne en fonction de l'index
    final int col = index % 13;  // Utiliser le reste de la division pour obtenir la colonne
    final lettre = _plateau.getCasePlateau(row, col); // Récupérer la lettre pour cette case

    return InkWell(
      onTap: () {
        setState(() {
          //_selectedLetter = letter;
          // Vous pouvez ajouter des actions ici si nécessaire
          _MAJSelectLettre(lettre); // Mettre à jour la lettre sélectionnée
        });
      },
      child: Container(
        child: Center(
          child: Text(
            "$lettre",
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }

  void _MAJSelectLettre(String lettre) {
    setState(() {
      _selectLettre = lettre; // Mettre à jour la lettre sélectionnée
    });
  }



  //bouton recommencer
  _restartButton() {
    return Padding(
        padding: EdgeInsets.all(5),
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                gameInitialize();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(
                  255, 66, 29, 2), // Couleur de fond du bouton (rouge)
            ),
            child: const Text("Rejouer")));
  }


}

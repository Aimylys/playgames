import 'dart:async';
import '../class/dames.dart';
import '../class/partie.dart';
import 'package:flutter/material.dart';
import '../../Vue/connexion.dart';

class Dames extends StatefulWidget {
  const Dames({super.key, required this.title});

  final String title;

  @override
  State<Dames> createState() => _Dames();
}

class _Dames extends State<Dames> {

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
          "Jeu de Dames",
          style: TextStyle(fontSize: 30.0),
        ),
      ],
    );
  }
  //widget retournant un tableau de 8/8 avec tt les cases
  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      child: GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemCount: 64,
        itemBuilder: (context, int index) {
          return _box(index);
        },
      ),
    );
  }

  //widget 1 case
  Widget _box(int index) {
    final int row = index ~/ 8;
    final int col = index % 8;
    String couleurCase = _plateau.getCouleurCase(row,col);
    bool isSelected = (row == _plateau.getselectRow() && col == _plateau.getselectCol());
    bool isAroundSelectedF = _plateau.isAroundSelectedFull(row, col);

    return InkWell(
      onTap: () {
        setState(() {
          if (_plateau.aUnPion(row,col)) {
            print ("etat du clic: "+_plateau.aUnPion(row,col).toString());
            // Premier clic : Sélectionne la case si elle contient un pion noir
            if (_plateau.pieceNoire(row, col)) {
              _plateau.setPosition(row, col);
            }
            if (_plateau.pieceBlanche(row, col)) {
              _plateau.setPosition(row, col);
            }
            print ("liste case dispo: "+_plateau.getCaseDispo().toString());
            /*int fromRow = _plateau.getselectRow();
            int fromCol = _plateau.getselectCol();
            int toRow = row;
            int toCol = col;

            // Vérifie si le déplacement est valide
            if (_plateau.isAroundSelectedFull == true && _plateau.aUnPion(row,col) == false) {
              _plateau.changeCase(fromRow, fromCol, toRow, toCol);
              _plateau.aUnPion(fromRow,fromCol) == _plateau.aUnPion(row,col);
            }*/
          } else {
            print ("etat du clic: "+_plateau.aUnPion(row,col).toString());

          }
        });
      },
      child: Container(
        color: isSelected
            ? Colors.redAccent // Couleur pour la case sélectionnée
            : (isAroundSelectedF ? Colors.red : (couleurCase == "blanche" ? Colors.white : Colors.brown)),
        child: Center(
          child: Text(
            "${_plateau.getCasePlateau(row, col)}",
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
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

import '../class/pendu.dart';
import '../class/partie.dart';
import 'package:flutter/material.dart';

class Pendu extends StatefulWidget {
  const Pendu({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Pendu> createState() => _Pendu();
}

class _Pendu extends State<Pendu> {
  List<String> _tabLettres = [];//voir toutes les lettres déjà utilisées
  String _selectLettre = '';//voir quel lettre on a selectionnée
  Plateau _plateau = Plateau();
  Partie partie = Partie();
  jeuPendu jeupendu = jeuPendu();
  String _motAleatoireEssai = '';
  int _essaisRestants = 7;
  List<bool> _tabMotVisible = []; //liste pour voir si visible ou nan
  List<String> _tabMot = []; //stock mot à deviner

  @override
  void initState() {
    gameInitialize();
    super.initState();
  }

  void gameInitialize() {
    _plateau.inittab();
    _plateau.getPlateau();
    _selectLettre = '';
    _tabLettres = [];
    _essaisRestants = 7;
    _motAleatoireEssai = jeupendu.getMotAleatoireSimple();
    _tabMot = _motAleatoireEssai.split('');//décomposé le mot lettre par lettre
    _tabMotVisible = List.generate(_tabMot.length, (_) => false);//toute les lettres en false pour les cacher
  }

  @override
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
                    color: Colors.brown,
                  ),
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
                "https://img.freepik.com/photos-gratuite/fond-texture-bois-lisse-marron_53876-100273.jpg?w=1380&t=st=1700042662~exp=1700043262~hmac=b78a03792087927e4bd1d2952f81c7921ac69be01023148d4256174ee03b0f55",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 0, width: 200),
              const Padding(padding: EdgeInsets.all(10)),
              _headerText(),
              const Padding(padding: EdgeInsets.all(10)),
              _restartButton(),
              const SizedBox(height: 10),
              _images(),
              const SizedBox(height: 10),
              Text(
                'Essaie restant : $_essaisRestants',
                style: const TextStyle(fontSize: 20),
              ),
              /*const SizedBox(height: 20),
              Text(
              'Mot sélectionné : $_motAleatoireEssai',
              style: const TextStyle(fontSize: 20),
              ),*/
              const SizedBox(height: 20),
              Text(
                'Mot à trouver :',
                style: const TextStyle(fontSize: 20),
              ),// Affichez les cases correspondant au nombre de lettres du mot à deviner
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _tabMot.map((letter) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          // Affichez la lettre si elle est révélée dans _tabMotVisible, sinon affichez une case vide
                          _tabMotVisible[_tabMot.indexOf(letter)] ? letter : '',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              /*const SizedBox(height: 20),
              Text(
                'Lettre sélectionnée : $_selectLettre',
                style: const TextStyle(fontSize: 20),
              ),*/
              const SizedBox(height: 20),
              Text(
                'Lettres utilisées : ${_tabLettres.join(', ')}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              _gameContainer(),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _images() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Stack( //Stack = superposer texte sur image
        children: [
          Image.asset(
              'assets/pendu/$_essaisRestants.png',
              fit: BoxFit.cover,
              width: 200
          ),
          if (_tabMotVisible.every((visible) => visible))
            Positioned(
              top: 50, // haut
              left: 20, // gauche
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.green, width: 2), // Contour rajout
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Vous avez gagné',
                  style: TextStyle(
                    color: Colors.black, // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          if (_essaisRestants == 0)
            Positioned(
              top: 50, // haut
              left: 20, // gauche
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.red, width: 2), // Contour rajout
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Vous avez perdu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 13,
        ),
        itemCount: 26,
        itemBuilder: (context, index) {
          return _box(index);
        },
      ),
    );
  }

  Widget _box(int index) {
    final int row = index ~/ 13;
    final int col = index % 13;
    final lettre = _plateau.getCasePlateau(row, col);

    return InkWell(
      onTap: () {
        setState(() {
          if (_essaisRestants >= 1 ) {
            _MAJSelectLettre(lettre);
            bool lettreTrouvee = false;
            // Vérifie si lettre appartient au mot
              // Si oui, révèle lettre
              for (int i = 0; i < _tabMot.length; i++) {
                print (_tabMot[i]);
                print (lettre);
                if (_tabMot[i] == lettre) {
                  _tabMotVisible[i] = true;
                  lettreTrouvee = true;
                }
              }
            if (!lettreTrouvee) {
              _tabLettres.add(lettre);
              _essaisRestants--;
            }
          }
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

  //affiche la lettre selectionnée
  void _MAJSelectLettre(String lettre) {
    setState(() {
      _selectLettre = lettre;
    });
  }

  Widget _restartButton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            gameInitialize();
          });
        },
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 66, 29, 2),
        ),
        child: const Text("Rejouer"),
      ),
    );
  }
}

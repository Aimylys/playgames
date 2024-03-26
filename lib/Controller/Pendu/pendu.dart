import '../class/pendu.dart';
import '../class/partie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:playdames/Api/apiuser.dart';
import 'package:playdames/Api/apiscorependu.dart';

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
  Map<String, dynamic> infosPendu = {};
  Map<String, dynamic> infosUser = {};

  @override
  void initState() {
    gameInitialize();
    super.initState();
    researchinfosUser();
  }
  void gameInitialize() {
    _plateau.inittab();
    _plateau.getPlateau();
    _selectLettre = '';
    _tabLettres = [];
    _essaisRestants = 7;
    _motAleatoireEssai = jeupendu.getMotAleatoireSimple();
    _tabMot = _motAleatoireEssai.split('');//split = décomposé le mot lettre par lettre
    _tabMotVisible = List.generate(_tabMot.length, (_) => false);//false pour les cacher
    //researchinfosUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.brown,
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
            /*Center(
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
            ),*/
            ElevatedButton(
              onPressed: () {
                // Appeler la fonction pour mettre à jour la base de données quand on reviens au menu
                updatePoints(infosPendu['points']);
                Navigator.pushNamed(context, '/menujeux');
              },
              child: Text('Retour au menu',
                style: TextStyle(
                color: Colors.white,
              ),),
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _points(), // Points à gauche
                  _headerText(), // Au milieu
                  _restartButton(), // Bouton de redémarrage à droite
                ],
              ),
              const SizedBox(height: 30),
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
              ),
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
                          // Affichez la lettre si E _tabMotVisible, sinon case vide
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
              const SizedBox(height: 30),
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

  Widget _points() {
    return Column(
      children: [
        Text(
          'Points : ${infosPendu['points'] ?? "N/A"}',
          style: TextStyle(fontSize: 30.0),
        ),
      ],
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
            _MAJPoints(); // Mettre à jour les points ici
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

  void _MAJPoints() {
    setState(() {
      if (_tabMotVisible.every((visible) => visible)) {
        infosPendu['points']  = infosPendu['points'] += 5;
        updatePoints(infosPendu['points']);
      }
      if (_essaisRestants == 0) {
        if(infosPendu['points'] >= 5) {
          infosPendu['points'] = infosPendu['points'] -= 5;
          updatePoints(infosPendu['points']);
        }
      }
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
        style : ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Ajustez le rayon ici
            ),
          ),
        ),
        child: const Text("Rejouer",
          style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }


  /*Future<void> researchinfosUser() async {
    //permet de garder en mémoire des données partagées
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString('email');
    if (email != null) {
      var infos = await getUser(email);
      setState(() {
        infosUser = infos;
      });
    } else {
      print(
          "L'email ou le token est null. Impossible de récupérer les statistiques.");
    }
  }*/

  void researchinfosUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString('email');
    if (email != null) {
      var infos = await getUser(email);
      if (infos['id'] != null) {
        var userId = infos['id'];
        var score = await getUserScore(userId);
        if (score != null) {
          setState(() {
            infosPendu['points'] = score;//score ici =15
          });
        } else {
          await createUserScore(userId);
          setState(() {
            infosPendu['points'] = 10;
          });
        }
      }
    } else {
      print("L'email ou le token est null. Impossible de récupérer les statistiques.");
    }

  }

  //prend le dernier résultat des points
  void updatePoints(int newPoints) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString('email');
    if (email != null) {
      var infos = await getUser(email);
      if (infos['id'] != null) {
        var userId = infos['id'];
        await updateUserScore(newPoints); // Mettre à jour les points dans la base de données
      }
    } else {
      print("L'email ou le token est null. Impossible de mettre à jour les statistiques.");
    }
  }

}

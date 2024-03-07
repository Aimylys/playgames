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
  List<String> _tabLettres = [];
  String _selectLettre = '';
  Plateau _plateau = Plateau();
  Partie partie = Partie();

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
              const SizedBox(height: 30, width: 200),
              const Padding(padding: EdgeInsets.all(10)),
              _headerText(),
              const SizedBox(height: 20),
              Text(
                'Lettre sélectionnée : $_selectLettre',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              _gameContainer(),
              const SizedBox(height: 10),
              Text(
                'Lettres utilisées : ${_tabLettres.join(', ')}',
                style: const TextStyle(fontSize: 20),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              _restartButton(),
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
          _MAJSelectLettre(lettre);
          _tabLettres.add(lettre);
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

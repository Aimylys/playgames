import 'package:flutter/material.dart';
import 'jeuPendu.dart';
import 'dart:async';

class Pendus extends StatefulWidget {
  const Pendus({super.key, required this.title});

  final String title;

  @override
  State<Pendus> createState() => _Pendus();
}

class _Pendus extends State<Pendus> {
  final JeuPendu _jeu = JeuPendu();
  String _lettreSelectionnee = '';

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
      body: Column(
        children: [
          // Affichage du mot en cours de devinette
          Text(
            _jeu.progres.join(' '),
            style: TextStyle(fontSize: 24),
          ),
          // Affichage du nombre d'essais restants
          Text('Essais restants: ${_jeu.essaisRestants}'),
          // Affichage de l'image du pendu
          // Gestion des boutons de lettres
          GridView.count(
            crossAxisCount: 6,
            children: List.generate(
              26,
                  (index) => BoutonLettre(
                lettre: String.fromCharCode('A'.codeUnitAt(0) + index),
                onPressed: () {
                  setState(() {
                    _lettreSelectionnee =
                        String.fromCharCode('A'.codeUnitAt(0) + index);
                    _jeu.selectionnerLettre(_lettreSelectionnee);
                    if (_jeu.partieTerminee) {
                      // Gérer la fin de partie ici
                    }
                  });
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _jeu.reinitialiserPartie();
                _lettreSelectionnee = '';
              });
            },
            child: const Text('Nouvelle Partie'),
          ),
        ],
      ),
    );
  }
}

class BoutonLettre extends StatelessWidget {
  final String lettre;
  final VoidCallback onPressed;

  const BoutonLettre({Key? key, required this.lettre, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(lettre),
    );
  }
}
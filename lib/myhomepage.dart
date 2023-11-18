import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //Image.asset('assets/images/paradice_logo.png', fit: BoxFit.cover, width: 300),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                const Text(
                  'Bienvenue sur notre',
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              const Text(
                'jeu de Dames !',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              ])),
          const Padding(padding: EdgeInsets.only(bottom: 75)),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/route2');
              },
              child: const Text("Se connecter"),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.brown))),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/route3');
            },
            child: const Text("S'inscrire"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.brown),
            ),
          ),
        ],
      ),
    );
  }
}

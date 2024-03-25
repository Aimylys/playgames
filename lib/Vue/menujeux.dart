import 'dart:async';
import 'package:flutter/material.dart';
import 'connexion.dart';
import '../Controller/Dames/dames.dart';

class MenuJeux extends StatefulWidget {
  const MenuJeux({super.key, required this.title});

  final String title;

  @override
  State<MenuJeux> createState() => _Dames();
}

class _Dames extends State<MenuJeux> {
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
                  'Profil',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.brown),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/route4');
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ConnectPage(title: 'Connexion'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(135, 120, 97, 5)),
                child: const Icon(
                  Icons.power_settings_new,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Liste de Jeux',
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ])),
            const Padding(padding: EdgeInsets.only(bottom: 50)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pendu');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image
                  Image.asset(
                    'assets/pendu/7.png',
                    height: 100,
                  ),
                  const Text(
                    "Pendu",
                    style: TextStyle(fontSize: 16),
                  ),

                ],
              ),
            ),
      const Padding(padding: EdgeInsets.only(bottom: 50)),
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/pageMemory');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Image.asset(
              'assets/imagesMemory/point.png',
              height: 100,
            ),
            const Text(
              "Memory",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
          ],
        ),
      ),
    );
  }
}

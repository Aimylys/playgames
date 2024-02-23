import 'package:flutter/material.dart';

class Regle extends StatefulWidget {
  const Regle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Regle> createState() => _RegleState();
}

class _RegleState extends State<Regle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 239, 210, 30),
      appBar: AppBar(
        title: const Text(
          'Page des règles',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Dames'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: Column(children: [
                          const Text(
                            "Le but du jeu",
                            style: TextStyle(
                                fontFamily: 'Dames',
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          const Opacity(
                            opacity: 0.5,
                            child: Divider(
                              height: 30,
                              thickness: 2,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.black,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          const Text(
                            "A. Les règles du jeu \n"
                                "Rappel : L’objectif de la plateforme est de jouer au jeu de dames en ligne. Mais avant de"
                                "commencer, voici les règles internationales du jeu.\n"
                                "Le jeu de dames, dans sa variante française sur un plateau de 10x10, offre une complexité et une"
                                "stratégie accrues. Voici un aperçu détaillé des règles :",
                            style: TextStyle(
                                fontFamily: 'Dames',
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50)),
                          const Text(
                            "1. Le plateau et les pions :\n"
                                "Le jeu se déroule sur un plateau de 100 cases (10x10), alternativement claires et foncées. Seules 50"
                                "cases foncées sont utilisées. Chaque joueur possède 20 pions de sa couleur (un joueur en blanc et"
                                "l'autre en noir) placés sur les quatre premières rangées de chaque côté.",
                            style: TextStyle(
                                fontFamily: 'Dames',
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50)),
                          const Text(
                            "2. Mouvement des pions :\n"
                                "Les pions se déplacent en diagonale d'une case à la fois, uniquement vers l'avant (vers le camp"
                                "adverse). Lorsqu'un pion atteint la dernière rangée du côté adverse, il est couronné 'dame', offrant"
                                "ainsi plus de flexibilité dans les mouvements.",
                            style: TextStyle(
                                fontFamily: 'Dames',
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50)),
                          const Text(
                            "3. Les prises :\n"
                                "- Pour les pions : Si un pion adverse se trouve en diagonale directement à côté d'un pion et que la"
                                "case derrière ce pion adverse est vide, alors le pion adverse peut être 'pris' en sautant par-dessus."
                                "La prise est obligatoire.\n"
                                "- Pour les dames : Elles peuvent prendre des pions (ou d'autres dames) à distance, en glissant sur"
                                "plusieurs cases avant ou après la prise, tant en avant qu'en arrière. Si après avoir effectué une prise,"
                                "une autre prise est possible (même en reculant), elle doit être réalisée dans la même séquence.\n"
                                "- Un pion ou une dame ne peut sauter par-dessus un pion adverse que s'il est isolé, c'est-à-dire"
                                "sans autre pion directement derrière lui.",
                            style: TextStyle(
                                fontFamily: 'Dames',
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50)),
                          const Text(
                            "4. Promotion en dame :\n"
                                "Quand un pion arrive à la rangée la plus éloignée du joueur, il est promu en 'dame'. Cette dame"
                                "peut se déplacer en avant ou en arrière, sur n'importe quel nombre de cases en diagonale, sans être"
                                "bloquée par un autre pion de sa propre couleur.",
                            style: TextStyle(
                                fontFamily: 'Dames',
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50)),
                          const Text(
                            "5. Fin de la partie :\n"
                                "La partie s'achève quand un joueur ne peut plus bouger ou n'a plus de pions sur le plateau."
                                "L'adversaire est alors déclaré vainqueur.",
                            style: TextStyle(
                                fontFamily: 'Dames',
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50)),
                        ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

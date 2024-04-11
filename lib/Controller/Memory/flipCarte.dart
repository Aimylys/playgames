import 'dart:core';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../Vue/connexion.dart';
import 'carte.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FlipCarte extends StatefulWidget {
  final Niveau _niveau;
  FlipCarte(this._niveau);

  @override
  _FlipCarteState createState() => _FlipCarteState(_niveau);
}

class _FlipCarteState extends State<FlipCarte> {
  int _indexAvant = -1;
  bool _flip = false;
  bool _start = false;
  bool _att = false;
  Niveau _niveau;
  Timer? _timer;
  int _time = 5;
  int _restant = 0;
  bool _estFini = false;
  late List<String> _carte;
  late List<bool> _carteFlip;
  late List<GlobalKey<FlipCardState>> _carteStateKeys;

  int _tempPasse = 0;
  int _score = 0;
  Timer? _chrono;

  _FlipCarteState(this._niveau) {
    // Initialisez les variables ici
    _carte = [];
    _carteFlip = [];
    _carteStateKeys = [];
  }

  Widget getCarte(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(4.0),
      child: Image.asset(_carte[index]),
    );
  }

  startTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _time = _time - 1;
      });
    });
  }

  startChrono() async {
    _chrono = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _tempPasse++;
      });
    });
  }

  void restart() {
    _tempPasse = 0;
    _score = 0;
    startTimer();
    startChrono();
    _carte = getTableauImage(
      _niveau,
    );
    _carteFlip = getInitialStateCarte(_niveau);
    _carteStateKeys = getCarteStateKeys(_niveau);
    _time = 5;
    _restant = (_carte.length ~/ 2);

    _estFini = false;
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        _start = true;
        _timer?.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    restart();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Annuler la minuterie _timer
    _chrono?.cancel();
    super.dispose();
  }

  int calculScore() {
    if (_tempPasse <= 45) {
      _score = 3;
    } else if (_tempPasse <= 120 && _tempPasse > 45) {
      _score = 2;
    } else if (_tempPasse <= 180 && _tempPasse > 120) {
      _score = 1;
    } else {
      _score = 0; 
    }
    return _score;
  }

  Future<void> envoyerScoreAPI(int score) async {
  Map<String, dynamic> scoreData = {
    'scoreM': score,
  };
  String jsonData = convert.jsonEncode(scoreData);

  print('Données JSON envoyées : $jsonData');

  try {
    http.Response response = await http.post(
      Uri.parse('https://s3-4677.nuage-peda.fr/api_playgames/public/api/memories'),
      headers: <String, String>{
        'Content-Type': 'application/ld+json', // Utilisez 'application/ld+json' comme type de contenu
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      print('Score envoyé avec succès: $score');
      print('Réponse du serveur : ${response.body}');
    } else {
      print('Échec de l\'envoi du score. Code d\'état : ${response.statusCode}');
      print('Réponse du serveur : ${response.body}');
    }
  } catch (e) {
    print('Erreur lors de l\'envoi du score: $e');
  }
}




  @override
  Widget build(BuildContext context) {
    if (_estFini) {
    _chrono?.cancel(); // Arrêter le chronomètre si le jeu est terminé
    _score = calculScore();
    envoyerScoreAPI(_score);
    }

    return _estFini
        ? Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Votre partie a duré $_tempPasse secondes et vous avez gagner $_score points',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        restart();
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Text(
                        "Rejouer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _time > 0
                              ? Text(
                                  '$_time',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                )
                              : Text(
                                  'Restant: $_restant',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                          const SizedBox(height: 10),
                          Text(
                            'Temps écoulé: $_tempPasse secondes',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) => _start
                            ? FlipCard(
                                key: _carteStateKeys[index],
                                onFlip: () {
                                  if (!_flip) {
                                    _flip = true;
                                    _indexAvant = index;
                                  } else {
                                    _flip = false;
                                    if (_indexAvant != index) {
                                      if (_carte[_indexAvant] !=
                                          _carte[index]) {
                                        _att = true;

                                        Future.delayed(
                                            const Duration(milliseconds: 1500),
                                            () {
                                          _carteStateKeys[_indexAvant]
                                              .currentState
                                              ?.toggleCard();
                                          _indexAvant = index;
                                          _carteStateKeys[_indexAvant]
                                              .currentState
                                              ?.toggleCard();

                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            setState(() {
                                              _att = false;
                                            });
                                          });
                                        });
                                      } else {
                                        _carteFlip[_indexAvant] = false;
                                        _carteFlip[index] = false;
                                        print(_carteFlip);

                                        setState(() {
                                          _restant -= 1;
                                        });
                                        if (_carteFlip
                                            .every((t) => t == false)) {
                                          print("Gagner");
                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            setState(() {
                                              _estFini = true;
                                              _start = false;
                                            });
                                          });
                                        }
                                      }
                                    }
                                  }
                                  setState(() {});
                                },
                                flipOnTouch: _att ? false : _carteFlip[index],
                                direction: FlipDirection.HORIZONTAL,
                                front: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 3,
                                          spreadRadius: 0.8,
                                          offset: Offset(2.0, 1),
                                        )
                                      ]),
                                  margin: const EdgeInsets.all(4.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/imagesMemory/interrogation.png",
                                    ),
                                  ),
                                ),
                                back: getCarte(index))
                            : getCarte(index),
                        itemCount: _carte.length,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}

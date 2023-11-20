import 'package:flutter/material.dart';
import 'dart:math';
import 'plateau.dart';

class Partie {
  bool _gameEnd = false;
  Plateau _plateau = new Plateau();

  Partie() {

  }

  void init() {
    //if (_plateau.getCouleurCase(x, y) == "noire" && (x == 6 || x == 7)) {}
  }

  bool getGameEnd() {
    return _gameEnd;
  }

  Plateau getPlateau() {
    return this._plateau;
  }

  void initialisationGame() {
    //_plateau.init();
  }
}

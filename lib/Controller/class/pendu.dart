import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';
import 'fruitssimples.dart';

class jeuPendu {
  String _motAleatoire = ''; //motActuel
  List<String> _progres =[];
  int _essaisRestants = 7;
  bool _partieTerminee = false;
  bool _partieGagnee = false;
  jeuPendu(){
    _motAleatoire = getMotAleatoireSimple();
    _progres = List.filled(_motAleatoire.length, '●');
  }

  String getMotAleatoireSimple() {
    Random random = Random();
    int index = random.nextInt(FruitsSimples.mots.length);
    return FruitsSimples.mots[index];
  }

  String getMotAleatoire() {
    return _motAleatoire;
  }

  //voir si la lettre selectionné fait partie du mot ou non et si la partie est terminé
  void selectionnerLettre(String lettre) {
    if (!_partieTerminee) {
      if (_motAleatoire.contains(lettre)) {
        for (int i = 0; i < _motAleatoire.length; i++) {
          if (_motAleatoire[i] == lettre) {
            _progres[i] = lettre;
          }
        }
        if (!_progres.contains('●')) {
          _partieTerminee = true;
          _partieGagnee = true;
        }
      } else {
        _essaisRestants--;
        if (_essaisRestants == 0) {
          _partieTerminee = true;
        }
      }
    }
  }

  void reinitialiserPartie() {
    //_motAleatoire = getMotAleatoireSimple();
    _progres = List.filled(_motAleatoire.length, '●');
    _essaisRestants = 7;
    _partieTerminee = false;
    _partieGagnee = false;
  }
}








//pour le plateau de lettre
class Plateau {
  int _selectedRow = -1;
  int _selectedCol = -1;
  List<List<String>> _occuper = [
  ["a","b","c","d","e","f","g","h","i","j","k","l","m"],
  ["n","o","p","q","r","s","t","u","v","w","x","y","z"],
  ];

  Plateau();

  void inittab(){
    _occuper = [
      ["a","b","c","d","e","f","g","h","i","j","k","l","m"],
      ["n","o","p","q","r","s","t","u","v","w","x","y","z"],
    ];
  }

  int getPlateauLength() {
    return _occuper.length;
  }

  List<List<String>> getPlateau(){
    return _occuper;
  }

  String getCasePlateau(int x,int y){
    return this._occuper[x][y];
  }

  int getselectRow() {return _selectedRow;}

  int getselectCol() {return _selectedCol;}

  void setPosition(int row, int col) {
    _selectedRow = row;
    _selectedCol = col;
    //_pioncolor = pionColor;
  }

}
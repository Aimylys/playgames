import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';

class Plateau {
  bool _isFirstClick = true;
  int _selectedRow = -1;
  int _selectedCol = -1;
  String _pioncolor = "";

  List<List<String>> _occuper = [];


  Plateau();

  void inittab(){
    _occuper = [
      ["","⚫","","⚫","","⚫","","⚫"],
      ["⚫","","⚫","","⚫","","⚫",""],
      ["","⚫","","⚫","","⚫","","⚫"],
      ["","","","","","","",""],
      ["","","","","","","",""],
      ["⚪","","⚪","","⚪","","⚪",""],
      ["","⚪","","⚪","","⚪","","⚪"],
      ["⚪","","⚪","","⚪","","⚪",""],
    ];
  }

  int getPlateauLength() {
    return _occuper.length;
  }


  String getCouleurCase(int row, int col) {
    return (row + col) % 2 == 0 ? "blanche" : "noire";
  }

  List<List<String>> getPlateau(){
    return _occuper;
  }

  String getCasePlateau(int x,int y){
    return this._occuper[x][y];
  }


  void changeCase(int fromRow, int fromCol, int toRow, int toCol) {
    if (mouvValid(fromRow, fromCol, toRow, toCol)) {
      _occuper[toRow][toCol] = _occuper[fromRow][fromCol];
      _occuper[fromRow][fromCol] = ""; // Vide la case d'origine
      // Met à jour l'état du clic après le déplacement
      if (!_isFirstClick) {
        _isFirstClick = true;
      }
    }
  }


  bool mouvValid(int fromRow, int fromCol, int toRow, int toCol) {
    if (_isFirstClick) {
      // Premier clic : Vérifie si la case contient un pion noir
      return pieceNoire(fromRow, fromCol) && caseNoire(fromRow, fromCol);
    } else {
      // Deuxième clic : Vérifie si le déplacement est en diagonale vers le bas sur une case noire vide
      return mouvDiag(fromRow, fromCol, toRow, toCol) &&
          caseNoire(toRow, toCol) &&
          caseVide(toRow, toCol);
    }
  }

  bool mouvDiag(int fromRow, int fromCol, int toRow, int toCol) {
    int rowDiff = toRow - fromRow;
    int colDiff = toCol - fromCol;
    return (rowDiff.abs() == 1 && colDiff.abs() == 1);
  }

  bool pieceNoire(int row, int col) {
    return _occuper[row][col] == "⚫";
  }
  bool pieceBlanche(int row, int col) {
    return _occuper[row][col] == "⚪";
  }

  bool caseNoire(int row, int col) {
    return (row + col) % 2 == 1; // Vérifie si la case est noire
  }

  bool caseVide(int row, int col) {
    return _occuper[row][col] == "";
  }

  bool isFirstClick() {
    return _isFirstClick;
  }

  void changeFirstClick(){
    this._isFirstClick = !_isFirstClick;
  }

  int getselectRow() {
    return _selectedRow;
  }

  int getselectCol() {
    return _selectedCol;
  }

  String getPionColor() {
    return _pioncolor;
  }

  void setPosition(int row, int col) {
    _selectedRow = row;
    _selectedCol = col;
    //_pioncolor = pionColor;
  }

  void resetPosition() {
    _selectedRow = -1;
    _selectedCol = -1;
    _pioncolor = "";
  }

  bool _PawnBlack(int row, int col) {
    return _occuper[row][col] == "⚫";
  }
  bool _PawnWhite(int row, int col) {
    return _occuper[row][col] == "⚪";
  }

  bool isAroundSelectedBlack(int row, int col) {
    return ((row == _selectedRow + 1) && (col == _selectedCol - 1 || col == _selectedCol + 1)) && !_PawnBlack(row, col);
  }

  bool isAroundSelectedWhite(int row, int col) {
    return ((row == _selectedRow - 1 ) && (col == _selectedCol - 1 || col == _selectedCol + 1)) && !_PawnWhite(row, col);
  }

  bool isAroundSelectedFull(int row, int col) {
    return ((row == _selectedRow - 1 || row == _selectedRow + 1) && (col == _selectedCol - 1 || col == _selectedCol + 1)&& !_PawnWhite(row, col)) && !_PawnBlack(row, col);
  }




}


// Fonction pour obtenir la couleur d'une case à une position donnée
/*String getCouleurCase() {
    for (int i = 0; i < occuper.length; i++) {
      for (int j = 0; j < occuper.length; j++) {
        if (occuper[i][j] == 1) {
          couleur = "noire";
        }else{
          couleur = "blanche";
        }
      }
    }
    return couleur;
  }*/


/*void placerPions() {
    for (int i = 0; i < occuper.length; i++) {
      if (occuper[i][0] == 1) {
        occuper[i][0] = pion;
      }
      if (occuper[i][1] == 1) {
        occuper[i][1] = pion;
      }
      if (occuper[i][6] == 1) {
        occuper[i][6] = pion;
      }
      if (occuper[i][7] == 1) {
        occuper[i][7] = pion;
      }
    }
  }*/
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';

class Plateau {
  bool _isFirstClick = true;
  int _selectedRow = -1;
  int _selectedCol = -1;
  String _pioncolor = "";
  List<List<int>> _casedispo = [];
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

  List<List<int>> getCaseDispo(){
    //ajoutcasedispo(int row, int col)
    return _casedispo;
  }
  List<List<String>> getPlateau(){return _occuper;}

  String getCasePlateau(int x,int y){return this._occuper[x][y];}

  bool pieceNoire(int row, int col) {return _occuper[row][col] == "⚫";}
  bool pieceBlanche(int row, int col) {return _occuper[row][col] == "⚪";}

  bool caseNoire(int row, int col) {
    return (row + col) % 2 == 1; // Vérifie si la case est noire
  }

  bool caseVide(int row, int col) {
    return _occuper[row][col] == "";
  }

  bool aUnPion(int row, int col) {
    if (_PawnBlack(row,col) || _PawnWhite(row,col)){
      _isFirstClick = true;
    }else{
      _isFirstClick = false;
    }
    return _isFirstClick;}

  int getselectRow() {return _selectedRow;}

  int getselectCol() {return _selectedCol;}

  String getPionColor() {return _pioncolor;}

  void setPosition(int row, int col) {
    _selectedRow = row;
    _selectedCol = col;
    //_pioncolor = pionColor;
  }

  bool _PawnBlack(int row, int col) {
    return _occuper[row][col] == "⚫";
  }
  bool _PawnWhite(int row, int col) {
    return _occuper[row][col] == "⚪";
  }

  //fonction booléenne retournant les case ou un pion noir ou blanc peut se déplacer
  bool isAroundSelectedFull(int row, int col) {
    return ((row == _selectedRow - 1 || row == _selectedRow + 1) && (col == _selectedCol - 1 || col == _selectedCol + 1)&& !_PawnWhite(row, col)) && !_PawnBlack(row, col);
  }

  //ajout dans un tableau les case disponible où on peut se déplacer(case rouge foncé)
  List<List<int>> ajoutcasedispo(int row, int col){
    if (isAroundSelectedFull(row,col)){
      //_casedispo = _casedispo.add([row,col]);
    }
    return _casedispo;
  }


  void changeCase(int fromRow, int fromCol, int toRow, int toCol) {
    if (isAroundSelectedFull == true) {
      _occuper[toRow][toCol] = _occuper[fromRow][fromCol];
      _occuper[fromRow][fromCol] = ""; // Vide la case d'origine
    }
  }
}
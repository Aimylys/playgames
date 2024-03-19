import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';

class Plateau {
  int _selectedRow = -1;
  int _selectedCol = -1;
  List<List<String>> _occuper = [
  ["A","B","C","D","E","F","G","H","I","J","K","L","M"],
  ["N","O","P","Q","R","S","T","U","V","W","X","Y","Z"],
  ];

  Plateau();

  void inittab(){
    _occuper = [
      ["A","B","C","D","E","F","G","H","I","J","K","L","M"],
      ["N","O","P","Q","R","S","T","U","V","W","X","Y","Z"],
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
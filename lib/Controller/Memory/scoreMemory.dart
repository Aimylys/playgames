import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api/apimemory.dart';
import 'package:http/http.dart' as http;

class scoreMemory extends StatefulWidget {
  @override
  _scoreMemoryState createState() => _scoreMemoryState();
}

class _scoreMemoryState extends State<scoreMemory> {
  int? memoryScore;

  @override
  void initState() {
    super.initState();
    recupMemoryScore();
  }

  void recupMemoryScore() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userId = localStorage.getInt('id');
    if (userId != null) {
      var score = await getMemoryScoreUser(userId);
      setState(() {
        memoryScore = score;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score du memorie'),
      ),
      body: Center(
        child: Text(
          'Votre score sur le memorie est! ${memoryScore ?? "non disponible"}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}




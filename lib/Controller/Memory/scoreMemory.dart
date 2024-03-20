import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import '../../Api/apimemory.dart';

class scoreMemory extends StatefulWidget {
  @override
  _scoreMemoryState createState() => _scoreMemoryState();
}

class _scoreMemoryState extends State<scoreMemory> {
  final ApiMemory _apiMemory = ApiMemory();
  late Future<List<int>> _memoryScores;

  @override
  void initState() {
    super.initState();
    _memoryScores = _apiMemory.fetchMemoryScores();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: _memoryScores,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          final scores = snapshot.data!;
          return ListView.builder(
              itemCount: scores.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text('Score: ${scores[index]}'),
                );
              }));
        }
      },
    );
  }
}


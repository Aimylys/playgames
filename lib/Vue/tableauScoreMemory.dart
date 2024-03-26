import 'package:flutter/material.dart';
import '../Controller/Memory/scoreMemory.dart';

class MemoryScoreEcran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Scores'),
      ),
      body: scoreMemory(),
    );
  }
}

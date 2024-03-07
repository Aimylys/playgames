import 'dart:math';

class JeuPendu {
  late List<String> _mots;
  late String _motActuel;
  late List<String> _progres;
  int _maxEssais = 7;
  int _essaisRestants = 7;
  bool _partieTerminee = false;
  bool _partieGagnee = false;

  JeuPendu() {
    _mots = [
      'PENDU',
      'FLUTTER',
      'DART',
      'PROGRAMMATION',
      // Ajoutez plus de mots ici
    ];
    _motActuel = _mots[Random().nextInt(_mots.length)];
    _progres = List.filled(_motActuel.length, '●');
  }

  List<String> get progres => _progres;
  int get essaisRestants => _essaisRestants;
  bool get partieTerminee => _partieTerminee;
  bool get partieGagnee => _partieGagnee;
  String get motActuel => _motActuel;

  void selectionnerLettre(String lettre) {
    if (!_partieTerminee) {
      if (_motActuel.contains(lettre)) {
        for (int i = 0; i < _motActuel.length; i++) {
          if (_motActuel[i] == lettre) {
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
    _motActuel = _mots[Random().nextInt(_mots.length)];
    _progres = List.filled(_motActuel.length, '●');
    _essaisRestants = _maxEssais;
    _partieTerminee = false;
    _partieGagnee = false;
  }
}

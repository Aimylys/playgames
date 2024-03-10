import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Niveau { expert, normal, debutant }

// fonction qui renvoie une liste d'URL d'images pour les cartes, ce sont les paires à faire conrrespondre
List<String> rempliTableauImage() {
  return [
    'assets/imagesMemory/elephant.png',
    'assets/imagesMemory/elephant.png',
    'assets/imagesMemory/gator.png',
    'assets/imagesMemory/gator.png',
    'assets/imagesMemory/gnou.png',
    'assets/imagesMemory/gnou.png',
    'assets/imagesMemory/hyena.png',
    'assets/imagesMemory/hyena.png',
    'assets/imagesMemory/lion.png',
    'assets/imagesMemory/lion.png',
    'assets/imagesMemory/panther.png',
    'assets/imagesMemory/panther.png',
    'assets/imagesMemory/rhino.png',
    'assets/imagesMemory/rhino.png',
    'assets/imagesMemory/snake.png',
    'assets/imagesMemory/snake.png',
    'assets/imagesMemory/vulture.png',
    'assets/imagesMemory/vulture.png',
    'assets/imagesMemory/zebra.png',
    'assets/imagesMemory/zebra.png',
  ];
}

// fonction qui renvoie un tableau d'image en fonction du niveau de jeux choisi
List<String> getTableauImage(
    Niveau niveau,
    ) {
  List<String> niveauEtCarteList = [];
  List<String> tableauImage =
  rempliTableauImage(); // Assurez-vous que la liste est de type String
  if (niveau == Niveau.expert) {
    tableauImage.forEach((element) {
      niveauEtCarteList.add(element);
    });
  } else if (niveau == Niveau.normal) {
    for (int i = 0; i < 12; i++) {
      niveauEtCarteList.add(tableauImage[i]);
    }
  } else if (niveau == Niveau.debutant) {
    for (int i = 0; i < 6; i++) {
      niveauEtCarteList.add(tableauImage[i]);
    }
  }

  niveauEtCarteList.shuffle();
  return niveauEtCarteList;
}

// fonction qui initialise l'état de chaque carte du jeu. Elle renvoie une liste de bool qui indique si la carte est retourner ou non
List<bool> getInitialStateCarte(Niveau niveau) {
  List<bool> initialStateCarte = [];
  if (niveau == Niveau.expert) {
    for (int i = 0; i < 20; i++) {
      initialStateCarte.add(true);
    }
  } else if (niveau == Niveau.normal) {
    for (int i = 0; i < 12; i++) {
      initialStateCarte.add(true);
    }
  } else if (niveau == Niveau.debutant) {
    for (int i = 0; i < 6; i++) {
      initialStateCarte.add(true);
    }
  }
  return initialStateCarte;
}

// fonction qui permet de controller l'état de chaque carte du jeux
List<GlobalKey<FlipCardState>> getCarteStateKeys(Niveau niveau) {
  List<GlobalKey<FlipCardState>> carteStateKeys = [];
  if (niveau == Niveau.expert) {
    for (int i = 0; i < 20; i++) {
      carteStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (niveau == Niveau.normal) {
    for (int i = 0; i < 12; i++) {
      carteStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (niveau == Niveau.debutant) {
    for (int i = 0; i < 6; i++) {
      carteStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return carteStateKeys;
}

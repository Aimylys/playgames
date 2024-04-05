import 'package:http/http.dart' as http;
import 'dart:convert';

//prend l'id de la ligne score correspondant au score du l'utilisateur
/*Future<int?> _getPenduId(int i){

}*/


//prend le score d'un user en fonction de son id ,ici on recup bien 1
Future<int?> getUserScore(int userId) async {
  try {
    final response = await http.get(
      Uri.parse('http://s3-4677.nuage-peda.frapi_playgames/public//api/pendus?page=1&user=$userId'),
      headers: {'Content-Type': 'application/ld+json'},
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var scores = responseData['hydra:member'];
      if (scores.isNotEmpty) {
        var score = scores[0];
        return score['score'];
      }
    }
  } catch (e) {
    print('Erreur lors de la récupération du score de l\'utilisateur: $e');
  }
  return null;
}

//créer une nouvelle ligne dans pendu avec score = 0 si le user n'a pas de score attitré
Future<void> createUserScore(int userId) async {
  try {
    final response = await http.post(
      Uri.parse('http://s3-4677.nuage-peda.frapi_playgames/public//api/pendus'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user': 'api_playgames/public//api/users/$userId', 'score': 0}),
    );

    if (response.statusCode == 201) {
      print('Score initial créé avec succès pour l\'utilisateur avec l\'ID: $userId');
    } else {
      print('Échec de la création du score initial pour l\'utilisateur avec l\'ID: $userId. Statut code: ${response.statusCode}');
    }
  } catch (e) {
    print('Erreur lors de la création du score initial pour l\'utilisateur avec l\'ID: $userId: $e');
  }
}

//mise à jour des points du user ap partie
Future<void> updateUserScore(int newScore) async {
  try {
    final response = await http.patch(
      Uri.parse('http://s3-4677.nuage-peda.frapi_playgames/public//api/pendus'),
      headers: {'Content-Type': 'application/merge-patch+json'},
      body: jsonEncode({'score': newScore}),
    );

    print(newScore);
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Score mis à jour avec succès pour l\'utilisateur avec l\'ID: ');
    } else {
      print('Échec de la mise à jour du score pour l\'utilisateur avec l\'ID: . Statut code: ${response.statusCode}');
      print('${response.body}');
    }
  } catch (e) {
    print('Erreur lors de la mise à jour du score pour l\'utilisateur avec l\'ID: : $e');
  }
}


//prend tout les points du pendus
Future<Map<String, dynamic>> getPointPendu() async {
  final response = await http.get(
    Uri.parse('http://s3-4677.nuage-peda.frapi_playgames/public//api/pendus?page=1'),
    headers: {'Content-Type': 'application/ld+json',},
  );

  //200 -> bon
  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    var pendu = responseData['hydra:member'];
    //si pendu n'est pas vide, prendre ses infos
    if (pendu.isNotEmpty) {
      var infosPendu = pendu[0];
      return {
        'id':infosPendu['id'],
        'points': infosPendu['points'],
      };
    } else {
      // Pendu inexistant -> Pendu associé à aucun score
      return {
        'points': null, // Points par défaut si jamais
      };
    }
  } else {
    // Gérer l'échec de la tentative de récupération des infos
    print(
        "Échec de la récupération des infos. Statut code: ${response.statusCode}");
    print("Réponse du serveur: ${response.body}");

    // Retourner une valeur par défaut
    return {
      'points': null,
    };
  }
}
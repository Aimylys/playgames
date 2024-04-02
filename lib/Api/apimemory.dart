import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int?> getMemoryScoreUser(int userId) async {
  try {
    final response = await http.get(
      Uri.parse('http://s3-4677.nuage-peda.fr/playgames/api/memories?page=1&user=$userId'),
      headers: {'Content-Type': 'application/ld+json'},
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      var scores = responseData['hydra:member'];
      if (scores.isNotEmpty) {
        var score = scores[0];
        return score['scoreM'];
      }
    }
  } catch (e) {
    print ('Erreur lors de la récupération, votre score est actuellement indisponible: $e');
  }
  return null;
}

Future<void> createMemoryUserScore(int userId) async {
  try {
    final response = await http.post(
      Uri.parse('http://s3-4677.nuage-peda.fr/playgames/api/memories'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user': '/playgames/api/users/$userId', 'scoreM': 0}),
    );

    if (response.statusCode == 201) {
      print('création du score avec succès pour l\'utilisateir dont l\'id est: $userId');
    } else {
      print('echec de la création du score pour l\'utilisateir dont l\'id est: $userId');
    }
  } catch (e) {
    print('Erreur lors de la création du score pour l\'utilisateur dont l\'id est: $userId: $e'); 
  }
}

Future<void> majMemoryUserScore(int userId, int nouveauScore) async {
  try {
    final response = await http.patch(
      Uri.parse('http://s3-4677.nuage-peda.fr/playgames/api/memories/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'scoreM': nouveauScore}),
    );

    print(userId);
    print(nouveauScore);
    print(response);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('La mise a jour du score pour l\'utilisateur $userId est un succès');
    } else {
      print('La mise a jour du score pour l\'utilisateur $userId est un echec? Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Erreur lors de la mise à du score de l\"utilisateur. $e');
  }
}

Future<Map<String, dynamic>> getPointMemory() async {
  final response = await http.get(
    Uri.parse('http://s3-4677.nuage-peda.fr/playgames/api/memories?page=1'),
    headers: {'Content-Type': 'application/ld+json',},
  );

  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    var memorie = responseData['hydra:member'];
    if (memorie.isNotEmpty) {
      var infoMemo = memorie[0];
      return {
        'id':infoMemo['id'],
        'points':infoMemo['scoreM'],
      };
    } else {
      return {
        'points': null,
      };
    }
  } else {
    print("Impossible de récupérer les informations. Status code: ${response.statusCode}");
    print("Reponse du serveur: ${response.body}");
    return { 'points': null};
  }
}
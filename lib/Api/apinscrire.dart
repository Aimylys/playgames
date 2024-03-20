import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> EmailVerifier(String email) async {
  try {
    final response = await http.get(Uri.parse('https://s3-4668.nuage-peda.fr/playgames/api/users?email=$email'));

    final jsonDonnee = json.decode(response.body);
    final hydramember = jsonDonnee['hydra:member'] as List<dynamic>;

    if (hydramember.isEmpty) {
      // Aucun utilisateur trouvé avec cet email.
      return false;
    } else {
      return true;
    }
  } catch (e) {
    // Gérer les erreurs ici
    print('Erreur lors de la vérification de l\'email: $e');
    return false;
  }
}

Future<void> inscription(String email, String password, String nom, String prenom) async {
  try {
    final response = await http.post(Uri.parse('https://s3-4668.nuage-peda.fr/playgames/api/users'),
        headers: {
          'Content-Type': 'application/ld+json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'nom': nom,
          'prenom': prenom,
          "dateInscription": DateTime.now().toIso8601String(),
          "points": 0, // instancie les points à 0 si NULL
        }));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      print('Utilisateur inscrit avec succès.');
    } else {
      print('Erreur lors de l\'inscription: ${response.statusCode}');
    }
  } catch (e) {
    // Gérer les erreurs ici
    print('Erreur lors de l\'inscription: $e');
  }
}

bool isEmailValid(String email) {
  // Utilisez une expression régulière pour vérifier si l'adresse e-mail est valide
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return emailRegex.hasMatch(email);
}

bool mdpChiffree(String value) {
  // Utiliser REGEX pour vérifier la présence d'un chiffre ou d'un caractère spécial
  final mdpRX = RegExp(r'[0-9!@#%^&*(),.?":{}|<>]');
  return mdpRX.hasMatch(value);
}

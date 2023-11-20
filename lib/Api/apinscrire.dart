import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> EmailVerifier(String email) async {
  final response = await http.get(Uri.parse('https://s3-4668.nuage-peda.fr/dame/api/users?email=$email'),);

  final jsonDonnee = json.decode(response.body);
  final hydramember = jsonDonnee['hydra:member'] as List<dynamic>;

  if (hydramember.isEmpty) {
    // Aucun user à cet email.
    return false;
  } else {
    return true;
  }
}

Future<void> inscription(String email, String password, String nom, String prenom) async {
  final response = await http.post(Uri.parse('https://s3-4668.nuage-peda.fr/dame/api/users'),
      headers: {
        'Content-Type': 'application/ld+json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'nom': nom,
        'prenom': prenom,
        "dateInscription": DateTime.now().toIso8601String(),
        "points": 0, //instancie les points à 0 si NULL
      }));
}

bool emailValide(String email) {
  // Utilisez du REGEX pour vérifier si l'e-mail est valide
  final emailRX = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return emailRX.hasMatch(email);
}

bool mdpChiffree(String value) {
  // Utilisez du REGEX pour vérifier la présence d'un chiffre ou d'un caractère spécial
  final mdpRX = RegExp(r'[0-9!@#%^&*(),.?":{}|<>]');
  return mdpRX.hasMatch(value);
}
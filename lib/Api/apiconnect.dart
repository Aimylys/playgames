import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class ApiConnect {
  token() async {
    SharedPreferences stockage = await SharedPreferences.getInstance();
    var token = stockage.getString('token');
    return '?token=$token';
  }


  Future<Map<String, dynamic>> connection(String email, String password) async {
    var donnee = {
      'email': email,
      'password': password,
    };

    //url plus vérification et autorisation token
    var Url = 'http://s3-4668.nuage-peda.fr/playgames/api/authentication_token' + await token();

    //chercher l'url avec le post api
    try {
      /*Response response = await http.post(
        Uri.parse(Url),
        body: jsonEncode(donnee),
        headers: <String, String>{
          'Content-Type': 'application/ld+json; charset=UTF-8',
        },
      );
      Response reponse = await http.post(
        Uri.parse('http://s3-4668.nuage-peda.fr/playgames/api/users?page=1&email=$email'),
        body: jsonEncode(email),
        headers: <String, String>{
          'Content-Type': 'application/ld+json',
        },
      );

      var jsonbody = json.decode(response.body);
      //var reponseData = json.decode(reponse.body);
      //var user = reponseData['hydra:member'];
      //var infosUser = user[0];
      //log(infosUser['id']);
      log(response.body.toString());
      log(reponse.body.toString());
      //message d'erreur 401 -> email ou password invalide
      if (response.statusCode == 401) {
        return {
          'status': 'error',
          'message': 'Identifiants invalides',
          'code': 401,
        };
      }*/
      Response response = await http.post(
        Uri.parse(Url),
        body: jsonEncode(donnee),
        headers: <String, String>{
          'Content-Type': 'application/ld+json; charset=UTF-8',
        },
      );

      Response reponse = await http.get(
        Uri.parse('http://s3-4668.nuage-peda.fr/playgames/api/users?page=1&email=$email'),
        //body: jsonEncode(email),
        headers: <String, String>{
          'Content-Type': 'application/ld+json',
        },
      );

      var jsonbody = json.decode(response.body);
      var reponseData = json.decode(reponse.body);
      log(response.body.toString());
      log(reponse.body.toString());

      // Vérifiez si la réponse est réussie et si des données d'utilisateur sont disponibles
      if (reponse.statusCode == 200 && reponseData['hydra:member'] != null) {
        var user = reponseData['hydra:member'];
        var infosUser = user[0];
        var userId = infosUser['id'];
        // Maintenant, userId contient l'ID de l'utilisateur connecté, vous pouvez l'utiliser comme nécessaire
        print('ID de l\'utilisateur connecté : $userId');
      } else {
        // Si la réponse est invalide ou si aucune donnée d'utilisateur n'est disponible
        print('Impossible de récupérer l\'ID de l\'utilisateur connecté.');
      }


      //si token n'est pas null alors validé le token et donné l'accès à la bdd
      if (jsonbody['token'] != null) {
        SharedPreferences stockage = await SharedPreferences.getInstance();
        stockage.setString('token', jsonbody['token']);
        stockage.setString('email', email);
        print('Email d\'utilisateur enregistré : ${stockage.getString('email')}');

        return {
          'status': 'success',
          'message': 'Connexion réussie',
          'code': 200,
        };
      }

      return {
        'status': 'error',
        'message': 'Erreur inconnue',
        'code': response.statusCode,
      };

      //retoune si erreur pour trouver l'api un catch disant que le server est fermé
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Server momentanément indisponible',
        'code': 503,
      };
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:developer';


class Inscription extends StatefulWidget {
  const Inscription({super.key, required this.title});


  final String title;

  @override
  InscriptionState createState() => InscriptionState();
}


class InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _password2 = "";
  String _nom = "";
  String _prenom = "";

  Future<http.Response> createAccount(
      String email, String password, String nom, String prenom) {
    return http.post(
      Uri.parse(
          'https://s3-4677.nuage-peda.fr/api_playgames/public/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/ld+json',
      },
      body: convert.jsonEncode(<String, dynamic>{
        "email": email,
        "roles": ["ROLE_USER"],
        "password": password,
        "nom": nom,
        "prenom": prenom,
        "points": 0,
        "totalMemoryScore": 0,
        "totalPenduScore": 0,
      }),
    );
  }

  void checkAccount() async {
    var connexion = await createAccount(_email, _password, _nom, _prenom);
    log(connexion.statusCode.toString());
    log(connexion.body.toString());
    if (connexion.statusCode == 201) {
      Navigator.pushReplacementNamed(context, '/route2');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Compte crée'),
      ));
    } else if (connexion.statusCode == 422) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login déjà utilisé'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Connexion au serveur impossible'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/connexion');
                },
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre email';
                    } else {
                      _email = valeur.toString();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Mot de passe"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    } else {
                      _password = valeur.toString();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Confirmation du mot de passe"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    } else if (valeur != _password) {
                      return 'Mots de passe différents';
                    } else {
                      _password2 = valeur.toString();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Prénom"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre prénom';
                    } else {
                      _prenom = valeur.toString();
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Nom"),
                  validator: (valeur) {
                    if (valeur == null || valeur.isEmpty) {
                      return 'Veuillez entrer votre nom';
                    } else {
                      _nom = valeur.toString();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      checkAccount();
                    }
                  },
                  child: const Text("S'inscrire"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


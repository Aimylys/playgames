import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../Vue/menujeux.dart';
import 'dart:io';
import '../Api/apiconnect.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String mdp = "";
  String txtButton = "Se connecter";
  bool _isLoading = false;

  Map<String, dynamic> dataMap = {};
  bool recupDataBool = false;

  Future<http.Response> recupConnect(String login, String mdp) {
    return http.post(
      Uri.parse(
          'http://s3-4677.nuage-peda.fr/api_playgames/public/api/authentication_token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
          convert.jsonEncode(<String, String>{'email': login, 'password': mdp}),
    );
  }

  Future<void> recupDataJson() async {
    var reponse = await recupConnect(email, mdp);
    if (reponse.statusCode == 200) {
      dataMap = convert.jsonDecode(reponse.body);
      recupDataBool = true;
    } else {
      print("erreur " + reponse.statusCode.toString());
    }
  }

  // methode qui permet la connection si les champs du formulaire sont valides
  startLoading() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await recupDataJson();
      // si les données ont été récupéré
      if (recupDataBool) {
        // on navige vers accueil en détruisant le context actuel
        Navigator.popAndPushNamed(context, '/menujeux', arguments: dataMap);
      } else {
        // sinon on affiche l'erreur et remet le booléen _isLoading à faux
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur dans la connection à la BDD"),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // affiche une erreur concernant la saisie des informations
      // et remet le booléen _isLoading à faux
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erreur dans le login/mdp"),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // login
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      hintText: "Saisir votre email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Erreur de saisie";
                    } else {
                      email = value;
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
              ),
              // password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mot de passe",
                      hintText: "Saisir votre mot de passe"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Erreur de saisie";
                    } else {
                      mdp = value;
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  // selon la valeur de _isLoading, le bouton s'adapte
                  onPressed: _isLoading ? null : startLoading,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(txtButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import '../Vue/menujeux.dart';
import 'dart:io';
import '../Api/apiconnect.dart';
import '../Api/apinscrire.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final id = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.brown,
          centerTitle: true,
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(top: 50)),
                const Text(
                  'Connectez-vous !!!',
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 50)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent, width: 2.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown, width: 2.5),
                      ),
                      hintText: 'E-mail',
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le champ d\'e-mail ne peut pas être vide';
                      }/* else if (EmailVerifier(value) == false) {
                        return 'Aucun compte n\'existe à cette adresse e-mail';
                      }*/
                      return null; // Return null when there's no error.
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 3.5, bottom: 3.5)),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.brown, width: 2.5),
                        ),
                        hintText: 'Mot de passe',
                        labelStyle: TextStyle(fontSize: 15),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le champ du mot de passe ne peut pas être vide';
                        }/* else if (EmailVerifier(value) == false) {
                          return 'mot de passe incorrect';
                        }*/
                        return null; // Return null when there's no error.
                      },
                    )),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(150, 40)),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // After all validations pass, perform login processing here.
                                    connexion(email.text,
                                        password.text);
                                  }
                                },
                                child: const Text(
                                  "Connexion",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  connexion(String email, String password) async {
    //Vérification de la connexion internet
      var internetConnect = await (Connectivity().checkConnectivity());
      if (internetConnect == ConnectivityResult.none) {
        // L'utilisateur n'a pas de connexion Internet
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Aucune connexion Internet. Veuillez vérifier votre connexion.',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            duration: Duration(seconds: 2), // Définir la durée de la SnackBar
          ),
        );
      } else {
      // Le user a une connexion internet, lancer les Api
      var result = await ApiConnect().connection(email, password);
      if (result['status'] == 'success') {
        // Connexion réussie
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MenuJeux(title: ""),
          ),
        );
      } else {
        //Erreurs éventuelles coté serveur en fonction du code récupéré(apiconnect.dart)
        int erreur = result['code'];
        if (erreur == 401) {
          // Identifiants invalides
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Identifiants invalides',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        } else if (erreur == 503) {
          // Serveurs éteins )
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Serveur momentanément indisponibles',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // Gérer d'autres erreurs
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Erreur inconnue',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }
}

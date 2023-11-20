import '../Api/apinscrire.dart';
import 'package:flutter/material.dart';
import 'connexion.dart';

class InscriptPage extends StatefulWidget {
  const InscriptPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<InscriptPage> createState() => _InscriptPageState();
}

class _InscriptPageState extends State<InscriptPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(239, 239, 210, 30),
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.brown,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  const Text(
                    'Inscrivez-vous !!!',
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  FutureBuilder<bool>(
                    future: EmailVerifier(email.text),
                    builder: (context, snapshot) {
                      final emailExists = snapshot.data;
                      return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                              //labelText permet de bouger le text en petit au dessus à gauche
                              //hintText permet de laisser le text dans la box sans bouger
                              hintText: 'Email',
                              labelStyle: TextStyle(fontSize: 18),
                              //quand on clique sur la case elle change en bleu
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent, width: 2.5),
                              ),
                              //couleur de base du container
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 2.5),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Le champ d\'e-mail ne peut pas être vide';
                              } else if (!emailValide(value)) {
                                return 'L\'adresse e-mail n\'est pas valide';
                              } else if (emailExists == false) {
                                return 'Un compte existe déjà à cet adresse e-mail';
                              }
                            },
                          ));
                    },
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 7.5)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: TextFormField(
                        controller: password,
                        decoration: const InputDecoration(
                          hintText: 'Mot de passe',
                          labelStyle: TextStyle(fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.brown, width: 2.5),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champ du mot de passe ne peut pas être vide';
                          } else if (value.length < 8) {
                            return 'Le mot de passe doit contenir au moins 8 caractères';
                          } else if (!mdpChiffree(value)) {
                            return 'Le mot de passe doit contenir au moins un chiffre ou un caractère spécial';
                          }
                          return null;
                        },
                      )),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 7.5)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: TextFormField(
                        controller: nom,
                        decoration: const InputDecoration(
                          hintText: 'Nom',
                          labelStyle: TextStyle(fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.brown, width: 2.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champ du prenom ne peut pas être vide';
                          }
                          return null;
                        },
                      )),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 7.5)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: TextFormField(
                        controller: prenom,
                        decoration: const InputDecoration(
                          hintText: 'Prénom',
                          labelStyle: TextStyle(fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.brown, width: 2.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champ du nom ne peut pas être vide';
                          }
                          return null;
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
                                      fixedSize: const Size(130, 40)),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      // After all validations pass, perform login processing here.
                                      inscription(email.text, password.text,
                                          nom.text, prenom.text);
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            const ConnectPage(title: ''),
                                      ));
                                    }
                                  },
                                  child: const Text(
                                    "S'inscrire",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]))),
                ],
              ),
            ),
          ),
        ));
  }
}

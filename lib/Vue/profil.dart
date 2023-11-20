import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/apiuser.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Map<String, dynamic> infosUser = {};

  @override
  void initState() {
    super.initState();
    researchinfosUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(

            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/profil/photoprofil.png',
                          height: 200,
                        )
                      ])),

              const Padding(padding: const EdgeInsets.only(bottom: 20)),
              SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          height: MediaQuery.of(context).size.height * 0.10,
              child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/profil/user.png',
                            height: 30,
                          )
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${infosUser['nom'] ?? "N/A"} ${infosUser['prenom'] ?? "N/A"}',
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ]),
                  ]),
      ),
              const Padding(padding: const EdgeInsets.only(bottom: 10)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: const Divider(
                  height: 12,
                  thickness: 3,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.brown,
                ),
              ),
              const Padding(padding: const EdgeInsets.only(bottom: 10)),
              SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          height: MediaQuery.of(context).size.height * 0.10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/profil/logocharge.png',
                            height: 50,
                          )
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${infosUser['points'] ?? "N/A"}',
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ]),
                  ]),
      ),
              const Padding(padding: const EdgeInsets.only(bottom: 10)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: const Divider(
                  height: 12,
                  thickness: 3,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.brown,
                ),
              ),
              const Padding(padding: const EdgeInsets.only(bottom: 10)),
              SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          height: MediaQuery.of(context).size.height * 0.10,
          child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/profil/mail.png',
                            height: 30,
                          )
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${infosUser['email'] ?? "N/A"}',
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ]),
                  ]),
            ),
              const Padding(padding: const EdgeInsets.only(bottom: 10)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/route7');
                  },
                  child: const Text("Classement des joueurs"),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.brown))),









            ]),
          ),
        );
  }

  Future<void> researchinfosUser() async {
    //permet de garder en mémoire des données partagées
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString('email');
    if (email != null) {
      var infos = await getUser(email);
      setState(() {
        infosUser = infos;
      });
    } else {
      print(
          "L'email ou le token est null. Impossible de récupérer les statistiques.");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/apiuser.dart';
import 'profil.dart';

class Classement extends StatefulWidget {
  const Classement({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Classement> createState() => _ClassementState();
}

class _ClassementState extends State<Classement> {
  Map<String, dynamic> infosUser = {};
  List<Map<String, dynamic>> listInfosUser = [];
  int diffpts = 0;

  @override
  void initState() {
    super.initState();
    researchinfosUser();
    researchClassUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Text(
                    'Classement des joueurs',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('N°')),
                      DataColumn(label: Text('Prénom')),
                      DataColumn(label: Text('Points')),
                    ],
                    rows: [
                      for (int i = 0; i < 5 && i < listInfosUser.length; i++)
                        DataRow(cells: [
                          DataCell(Text('${i + 1}')),
                          DataCell(Text("${listInfosUser[i]['prenom']}")),
                          DataCell(Text("${listInfosUser[i]['points']}")),
                        ]),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Vous avez ${infosUser['points'] ?? "N/A"} points',
                            style: const TextStyle(color: Colors.brown),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 1 && i < listInfosUser.length; i++)
                            if (listInfosUser[i]['points'] == infosUser['points'])
                              Text(
                                'Vous êtes en première place !!! ',
                                style: const TextStyle(color: Colors.black),
                              ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 1 && i < listInfosUser.length; i++)
                            if (listInfosUser[i]['points'] != infosUser['points'])
                              Text(
                                "Vous avez ${listInfosUser[i]['points'] - infosUser['points']} points d'écart avec le premier !!! ",
                                style: const TextStyle(color: Colors.black),
                              ),
                        ],
                      ),


                    ]),
                  )
                ],
              ),
            ));
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

  // Fonction pour récupérer le classement des joueurs
  Future<void> researchClassUser() async {
    var leaderboard = await getListUsers();

    setState(() {
      listInfosUser = leaderboard as List<Map<String, dynamic>>;
    });
  }

}

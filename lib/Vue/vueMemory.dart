import 'package:flutter/material.dart';

import '../Controller/Memory/flipCarte.dart';
import '../Controller/Memory/carte.dart';

class pageMemory extends StatefulWidget {
  @override
  _pageMemoryState createState() => _pageMemoryState();
}

class _pageMemoryState extends State<pageMemory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return _list[index].allerA;
                      }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: _list[index].primarycolor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black45,
                                  spreadRadius: 0.5,
                                  offset: Offset(3, 4))
                            ]),
                      ),
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: _list[index].secondarycolor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black12,
                                  spreadRadius: 0.3,
                                  offset: Offset(5, 3))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                                  _list[index].name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black26,
                                          blurRadius: 2,
                                          offset: Offset(1, 2),
                                        ),
                                        Shadow(
                                            color: Colors.green,
                                            blurRadius: 2,
                                            offset: Offset(0.5, 2))
                                      ]),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: etoilediff(_list[index].nbetoiles),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  List<Widget> etoilediff(int nb) {
    List<Widget> _icons = [];
    for (int i = 0; i < nb; i++) {
      _icons.insert(
          i,
          Icon(
            Icons.star,
            color: Colors.yellow,
          ));
    }
    return _icons;
  }
}

class Details {
  String name;
  Color primarycolor;
  Color secondarycolor;
  Widget allerA;
  int nbetoiles;

  Details(
      {required this.name,
        required this.primarycolor,
        required this.secondarycolor,
        required this.allerA,
        required this.nbetoiles});
}

List<Details> _list = [
  Details(
      name: "Facile",
      primarycolor: Colors.green,
      secondarycolor: const Color.fromARGB(255, 129, 199, 132),
      nbetoiles: 1,
      allerA: FlipCarte(Niveau.debutant)),
  Details(
      name: "Moyen",
      primarycolor: Colors.orange,
      secondarycolor: const Color.fromARGB(255, 255, 183, 77),
      nbetoiles: 2,
      allerA: FlipCarte(Niveau.normal)),
  Details(
      name: "Extrême",
      primarycolor: Colors.red,
      secondarycolor: const Color.fromARGB(255, 229, 115, 115),
      nbetoiles: 3,
      allerA: FlipCarte(Niveau.expert)),
];

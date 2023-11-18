import 'package:flutter/material.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
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
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.brown,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //Image.asset('assets/images/paradice_logo.png', fit: BoxFit.cover, width: 300),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                const Text(
                  'Se connecter',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ]),
            ),
            const Text(
              'En cours de confection ....',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playdames/Api/apinscrire.dart';
import 'package:playdames/Api/apiuser.dart';

void main() {
  Map<String, dynamic> infosUser = {};
  group('test retourner nom user existant', () {
    test('test nom',() async{
      String email = "denaison.emilie@gmail.com";
      var infos =await getUser(email);
      infosUser = infos;
      expect(infosUser['nom'], "Denaison");
    });
  });

  /*group('test retourner prenom user qui vient d\'etre créer', () {
    test('test creation',() async{
      String email = "denaison.fannie@gmail.com";
      String password = "iezjzidze";
      String nom = "Denaison";
      String prenom = "Fannie";
      await inscription(email, password, nom, prenom);
      var info =await EmailVerifier(email);
      //expect(info, true);
      var infos =await getUser(email);
      infosUser = infos;
      expect(infosUser['nom'], "Denaison");
    });
  });*/
}

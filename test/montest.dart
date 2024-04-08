// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

/*import 'package:flutter/material.dart';
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

  
}*/

/*
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:playdames/Api/apiconnect.dart'; // Assurez-vous d'importer la classe à tester
import 'package:http/http.dart' as http;
import 'dart:convert';

// Créez une classe Mock pour simuler les appels HTTP
class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Test de la fonction connection', () {
    test('Test de la connexion réussie', () async {
      // Définir les données d'entrée pour le test
      final email = "test@example.com";
      final password = "password";

      // Créez une instance de la classe de connexion
      final connectionService = ApiConnect();

      // Créez un client HTTP mocké pour simuler l'appel à l'API
      final mockClient = MockHttpClient();
      // Injectez le client HTTP mocké dans le service de connexion
      connectionService.client = mockClient;

      // Définissez la réponse attendue de l'appel API
      final expectedResponse = {
        'status': 'success',
        'message': 'Connexion réussie',
        'code': 200,
      };
      final fakeResponse = http.Response(jsonEncode(expectedResponse), 200);
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => fakeResponse);

      // Appelez la fonction à tester
      final response = await connectionService.connection(email, password);

      // Vérifiez si la réponse correspond à ce qui est attendu
      expect(response, expectedResponse);
    });

    test('Test de la connexion échouée', () async {
      // Définir les données d'entrée pour le test
      final email = "test@example.com";
      final password = "password";

      // Créez une instance de la classe de connexion
      final connectionService = ApiConnect();

      // Créez un client HTTP mocké pour simuler l'appel à l'API
      final mockClient = MockHttpClient();
      // Injectez le client HTTP mocké dans le service de connexion
      connectionService.client = mockClient;

      // Définissez la réponse attendue de l'appel API
      final expectedResponse = {
        'status': 'error',
        'message': 'Erreur inconnue',
        'code': 400, // Modifier le code d'erreur si nécessaire
      };
      final fakeResponse = http.Response(jsonEncode(expectedResponse),
          400); // Modifier le code d'erreur si nécessaire
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => fakeResponse);

      // Appelez la fonction à tester
      final response = await connectionService.connection(email, password);

      // Vérifiez si la réponse correspond à ce qui est attendu
      expect(response, expectedResponse);
    });

    test('Test de la connexion avec un serveur indisponible', () async {
      // Définir les données d'entrée pour le test
      final email = "test@example.com";
      final password = "password";

      // Créez une instance de la classe de connexion
      final connectionService = ApiConnect();

      // Créez un client HTTP mocké pour simuler l'appel à l'API
      final mockClient = MockHttpClient();
      // Injectez le client HTTP mocké dans le service de connexion
      //connectionService.client = mockClient;

      // Simulez une exception lors de l'appel à l'API
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenThrow(Exception('Server momentanément indisponible'));

      // Appelez la fonction à tester
      final response = await connectionService.connection(email, password);

      // Vérifiez si la réponse correspond à ce qui est attendu
      expect(response, {
        'status': 'error',
        'message': 'Server momentanément indisponible',
        'code': 503,
      });
    });
  });
}*/

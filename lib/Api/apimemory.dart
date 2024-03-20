import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiMemory {
  Future<List<int>> fetchMemoryScores() async {
    final response = await http.get(Uri.parse('https://s3-4677.nuage-peda.fr/api_playgames/public/api/memories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => e['scoreM'] as int).toList();
    } else {
      throw Exception('echec du chargement des score du memory');
    }
  }
}
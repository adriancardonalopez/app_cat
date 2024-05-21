import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cat_app/models/cat.dart';

class ApiService {
  static const String _baseUrl = 'https://api.thecatapi.com/v1/images/search?limit=10';

  Future<List<Cat>> fetchCats() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Cat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cats');
    }
  }
}

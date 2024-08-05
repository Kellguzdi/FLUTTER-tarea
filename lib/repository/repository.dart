// lib/repositories/repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/modelo.dart';

class Repository {
  final String apiUrl = "https://vdovsf90b4.execute-api.us-east-2.amazonaws.com/Prod/modelos"; // Cambia la URL por la de tu API

  Future<List<Modelo>> fetchModelos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Modelo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load modelos');
    }
  }

  Future<void> addModelo(Modelo modelo) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(modelo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add modelo');
    }
  }

  Future<void> updateModelo(Modelo modelo) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${modelo.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(modelo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update modelo');
    }
  }

  Future<void> deleteModelo(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete modelo');
    }
  }
}

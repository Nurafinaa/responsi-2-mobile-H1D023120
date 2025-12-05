import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> post(String url, Map data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  Future<dynamic> put(String url, Map data) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  Future<dynamic> delete(String url) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    return jsonDecode(response.body);
  }

  Future<dynamic> get(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    return jsonDecode(response.body);
  }
}

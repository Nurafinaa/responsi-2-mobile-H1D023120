import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi2_mobile_paket2_h1d023120/model/inventaris.dart';
import 'package:responsi2_mobile_paket2_h1d023120/helpers/api_url.dart';

class InventarisBloc {
  static Future<List<Inventaris>> getInventaris() async {
    print("==== GET INVENTARIS ====");
    print("URL: ${ApiUrl.listInventaris}");
    
    final response = await http.get(Uri.parse(ApiUrl.listInventaris));
    
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List data = jsonResponse['data'];
      return data.map((e) => Inventaris.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  static Future<bool> addInventaris(Inventaris inv) async {
    final response = await http.post(
      Uri.parse(ApiUrl.createInventaris),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(inv.toJson()),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updateInventaris(Inventaris inv) async {
    final response = await http.put(
      Uri.parse(ApiUrl.updateInventaris(inv.id!)),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(inv.toJson()),
    );

    return response.statusCode == 200;
  }

  static Future<bool> deleteInventaris(int id) async {
    final response = await http.delete(
      Uri.parse(ApiUrl.deleteInventaris(id)),
    );
    return response.statusCode == 200;
  }
}
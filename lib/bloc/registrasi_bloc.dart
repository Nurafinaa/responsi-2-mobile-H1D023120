import 'package:responsi2_mobile_paket2_h1d023120/helpers/api.dart';
import 'package:responsi2_mobile_paket2_h1d023120/helpers/api_url.dart';
import 'package:responsi2_mobile_paket2_h1d023120/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi;
    var body = {
      "nama": nama,
      "email": email,
      "password": password,
    };

    print("========== REGISTER REQUEST ==========");
    print(body);

    var jsonObj = await Api().post(apiUrl, body);

    print("========== REGISTER RESPONSE ==========");
    print(jsonObj);

    return Registrasi.fromJson(jsonObj);
  }
}

import 'package:responsi2_mobile_paket2_h1d023120/helpers/api.dart';
import 'package:responsi2_mobile_paket2_h1d023120/helpers/api_url.dart';
import 'package:responsi2_mobile_paket2_h1d023120/model/login.dart';

class LoginBloc {
  static Future<Login> login({
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.login;
    var body = {
      "email": email,
      "password": password,
    };

    print("========== LOGIN REQUEST ==========");
    print(body);

    var jsonObj = await Api().post(apiUrl, body);

    print("========== LOGIN RESPONSE ==========");
    print(jsonObj);

    return Login.fromJson(jsonObj);
  }
}

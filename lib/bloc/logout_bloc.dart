import 'package:responsi2_mobile_paket2_h1d023120/helpers/user_info.dart';

class LogoutBloc {
  static Future logout() async {
    await UserInfo().logout();
  }
}

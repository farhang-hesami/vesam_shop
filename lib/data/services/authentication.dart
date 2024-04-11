import 'package:vesam_shop/data/modeels/authentication.dart';
import 'package:vesam_shop/utils/http.client.dart';

class AuthenticationService {
  Future<void> register(Authentication authentication) async {
    await httpClient.post('accounts/signup', data: authentication.toJson());
  }

  Future<Authentication> login(Authentication authentication) async {
    var response =
        await httpClient.post('accounts/login', data: authentication.toJson());
    return Authentication.fromJson(response.data);
  }
}

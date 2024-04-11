import 'package:vesam_shop/data/modeels/home.dart';
import 'package:vesam_shop/data/modeels/user.dart';
import 'package:vesam_shop/utils/http.client.dart';

class HomeService {
  Future<HomeModel> getGeneralInfo() async {
    var response = await httpClient.get('home');
    return HomeModel.fromJson(response.data);
  }

  Future<User> getUserInfo() async {
    var response = await httpClient.get('users/me');
    return User.fromJson(response.data);
  }
}

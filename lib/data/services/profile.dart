import 'package:vesam_shop/data/modeels/user.dart';
import 'package:vesam_shop/utils/http.client.dart';

class ProfileService {
  Future<List<UserComments>> getUserComments() async {
    List<UserComments> userComments = [];
    var response = await httpClient.get('users/me/comments');
    for (var comment in response.data) {
      userComments.add(UserComments.fromJson(comment));
    }
    return userComments;
  }

  Future<List<UserPayments>> getUserPayment() async {
    List<UserPayments> userPayments = [];
    var response = await httpClient.get('users/me/succeeded-orders');
    for (var payment in response.data) {
      userPayments.add(UserPayments.fromJson(payment));
    }
    return userPayments;
  }
}

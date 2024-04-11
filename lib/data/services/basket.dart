import 'package:vesam_shop/data/modeels/basket.dart';
import 'package:vesam_shop/utils/http.client.dart';

class BasketService {
  Future<Basket> getAllBasket() async {
    var response = await httpClient.get('shopcarts');
    return Basket.fromJson(response.data);
  }

  Future<void> addBasket(int productId) async {
    await httpClient.post('shopcarts/add-product/$productId');
  }

  Future<void> increaseProductCount(int productId) async {
    await httpClient.patch('shopcarts/$productId/increase-count');
  }

  Future<void> decreaseProductCount(int productId) async {
    await httpClient.patch('shopcarts/$productId/decrease-count');
  }

  Future<void> deleteProductFromBasket(int productId) async {
    await httpClient.post('shopcarts/remove-product/$productId');
  }

  Future<String> payment(Payment payment) async {
    var response = await httpClient.post('https://flutter.vesam24.com/payment',
        data: payment.toJson());
    return response.data;
  }
}

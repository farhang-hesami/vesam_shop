import 'package:vesam_shop/data/modeels/product.dart';
import 'package:vesam_shop/utils/http.client.dart';

class ProductService {
  Future<ProductModel> getLatesProducts() async {
    var response = await httpClient.get('products?order=latest');
    return ProductModel.fromJson(response.data);
  }

  Future<ProductModel> getPopularProducts() async {
    var response = await httpClient.get('products?order=popular');
    return ProductModel.fromJson(response.data);
  }

  Future<ProductDetailModel> getDetailProduct(int productId) async {
    var response = await httpClient.get('products/$productId');
    return ProductDetailModel.fromJson(response.data);
  }

  Future<void> sendProductComment(Comments comments) async {
    await httpClient.post('comments', data: comments.toJson());
  }
}

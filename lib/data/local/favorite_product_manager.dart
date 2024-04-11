import 'package:hive_flutter/adapters.dart';
import 'package:vesam_shop/data/modeels/home.dart';

class FavoriteProductManager {
  static final Box<Product> favoriteProductBox =
      Hive.box<Product>('favorite_product');

  static Future<void> addProduct(Product product) async {
    await favoriteProductBox.put(product.id, product);
  }

  static Future<void> deleteProduct(Product product) async {
    await favoriteProductBox.delete(product.id);
  }

  static List<Product> getFavoriteProducts() {
    return favoriteProductBox.values.toList();
  }

  static bool isInBox(Product product) {
    return favoriteProductBox.containsKey(product.id);
  }
}

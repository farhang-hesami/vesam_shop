import 'package:hive_flutter/adapters.dart';

part 'home.g.dart';

class HomeModel {
  List<Product>? news;
  List<Slides>? slides;
  List<Product>? mostVisited;

  HomeModel({this.news, this.slides, this.mostVisited});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <Product>[];
      json['news'].forEach((v) {
        news!.add(Product.fromJson(v));
      });
    }
    if (json['slides'] != null) {
      slides = <Slides>[];
      json['slides'].forEach((v) {
        slides!.add(Slides.fromJson(v));
      });
    }
    if (json['mostVisited'] != null) {
      mostVisited = <Product>[];
      json['mostVisited'].forEach((v) {
        mostVisited!.add(Product.fromJson(v));
      });
    }
  }
}

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  double? price;
  @HiveField(3)
  double? discountPrice;
  @HiveField(4)
  bool? hasDiscount;
  @HiveField(5)
  int? discountPercent;
  @HiveField(6)
  String? image;

  Product(
      {this.id,
      this.title,
      this.price,
      this.discountPrice,
      this.hasDiscount,
      this.discountPercent,
      this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    hasDiscount = json['hasDiscount'];
    discountPercent = json['discountPercent'];
    image = json['image'];
  }
}

class Slides {
  String? title;
  String? image;
  String? url;

  Slides({this.title, this.image, this.url});

  Slides.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    url = json['url'];
  }
}

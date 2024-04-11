class Basket {
  num? totalPrice;
  num? totalDiscountPrice;
  num? totalFinalPrice;
  List<BasketProductItem>? items;

  Basket(
      {this.totalPrice,
      this.totalDiscountPrice,
      this.totalFinalPrice,
      this.items});

  Basket.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    totalDiscountPrice = json['totalDiscountPrice'];
    totalFinalPrice = json['totalFinalPrice'];
    if (json['items'] != null) {
      items = <BasketProductItem>[];
      json['items'].forEach((v) {
        items!.add(BasketProductItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPrice'] = totalPrice;
    data['totalDiscountPrice'] = totalDiscountPrice;
    data['totalFinalPrice'] = totalFinalPrice;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BasketProductItem {
  int? count;
  num? fee;
  num? price;
  num? discountPercent;
  num? discountPrice;
  num? finalPrice;
  String? productTitle;
  String? productImage;
  int? productId;

  BasketProductItem(
      {this.count,
      this.fee,
      this.price,
      this.discountPercent,
      this.discountPrice,
      this.finalPrice,
      this.productTitle,
      this.productImage,
      this.productId});

  BasketProductItem.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    fee = json['fee'];
    price = json['price'];
    discountPercent = json['discountPercent'];
    discountPrice = json['discountPrice'];
    finalPrice = json['finalPrice'];
    productTitle = json['productTitle'];
    productImage = json['productImage'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['fee'] = fee;
    data['price'] = price;
    data['discountPercent'] = discountPercent;
    data['discountPrice'] = discountPrice;
    data['finalPrice'] = finalPrice;
    data['productTitle'] = productTitle;
    data['productImage'] = productImage;
    data['productId'] = productId;
    return data;
  }
}

class Payment {
  String? receiverFullName;
  String? receiverPhoneNumber;
  String? receiverPostalCode;
  String? receiverAddress;

  Payment({
    this.receiverFullName,
    this.receiverPhoneNumber,
    this.receiverPostalCode,
    this.receiverAddress,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    receiverFullName = json['receiverFullName'];
    receiverPhoneNumber = json['receiverPhoneNumber'];
    receiverPostalCode = json['receiverPostalCode'];
    receiverAddress = json['receiverAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiverFullName'] = receiverFullName;
    data['receiverPhoneNumber'] = receiverPhoneNumber;
    data['receiverPostalCode'] = receiverPostalCode;
    data['receiverAddress'] = receiverAddress;
    return data;
  }
}

class User {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? registrationDate;

  User({this.fullName, this.email, this.phoneNumber, this.registrationDate});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    registrationDate = json['registrationDate'];
  }
}

class UserComments {
  String? productTitle;
  String? productImage;
  int? id;
  String? subject;
  String? text;
  String? userFullName;
  String? userEmail;
  int? productId;
  String? createDate;

  UserComments(
      {this.productTitle,
      this.productImage,
      this.id,
      this.subject,
      this.text,
      this.userFullName,
      this.userEmail,
      this.productId,
      this.createDate});

  UserComments.fromJson(Map<String, dynamic> json) {
    productTitle = json['productTitle'];
    productImage = json['productImage'];
    id = json['id'];
    subject = json['subject'];
    text = json['text'];
    userFullName = json['userFullName'];
    userEmail = json['userEmail'];
    productId = json['productId'];
    createDate = json['createDate'];
  }
}

class UserPayments {
  int? factorCode;
  String? receiverFullName;
  String? receiverPhoneNumber;
  String? receiverPostalCode;
  String? receiverAddress;
  String? createDate;
  List<InvoiceDetails>? invoiceDetails;

  UserPayments(
      {this.factorCode,
      this.receiverFullName,
      this.receiverPhoneNumber,
      this.receiverPostalCode,
      this.receiverAddress,
      this.createDate,
      this.invoiceDetails});

  UserPayments.fromJson(Map<String, dynamic> json) {
    factorCode = json['factorCode'];
    receiverFullName = json['receiverFullName'];
    receiverPhoneNumber = json['receiverPhoneNumber'];
    receiverPostalCode = json['receiverPostalCode'];
    receiverAddress = json['receiverAddress'];
    createDate = json['createDate'];
    if (json['invoiceDetails'] != null) {
      invoiceDetails = <InvoiceDetails>[];
      json['invoiceDetails'].forEach((v) {
        invoiceDetails!.add(InvoiceDetails.fromJson(v));
      });
    }
  }
}

class InvoiceDetails {
  num? count;
  num? fee;
  num? price;
  num? discountPercent;
  num? discountPrice;
  num? finalPrice;
  String? productTitle;
  String? productImage;
  int? productId;

  InvoiceDetails(
      {this.count,
      this.fee,
      this.price,
      this.discountPercent,
      this.discountPrice,
      this.finalPrice,
      this.productTitle,
      this.productImage,
      this.productId});

  InvoiceDetails.fromJson(Map<String, dynamic> json) {
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
}

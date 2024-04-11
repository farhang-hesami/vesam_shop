part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class LatestProductsPageStarted extends ProductEvent {}

class PopularProductsPageStarted extends ProductEvent {}

class ProductDetailPageStarted extends ProductEvent {
  final int productId;
  ProductDetailPageStarted(this.productId);
}

class SendProductComment extends ProductEvent {
  final Comments comments;
  SendProductComment(this.comments);
}

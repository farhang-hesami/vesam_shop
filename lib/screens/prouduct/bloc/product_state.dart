part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

// Latest
class GetLatestPrductSuccess extends ProductState {
  final ProductModel productModel;
  GetLatestPrductSuccess(this.productModel);
}

class GetLatestPrductError extends ProductState {
  final String error;
  GetLatestPrductError(this.error);
}

class GetLatestPrductLoading extends ProductState {}

//Popular

class GetPopularPrductSuccess extends ProductState {
  final ProductModel productModel;
  GetPopularPrductSuccess(this.productModel);
}

class GePopulartPrductError extends ProductState {
  final String error;
  GePopulartPrductError(this.error);
}

class GetPopularPrductLoading extends ProductState {}

// Detail
class GetPorductDetailSuccess extends ProductState {
  final ProductDetailModel productDetailModel;
  GetPorductDetailSuccess(this.productDetailModel);
}

class GetProductDetailError extends ProductState {
  final String error;
  GetProductDetailError(this.error);
}

class GetProductDetailLoding extends ProductState {}

// comment

class SendProductCommentSuccess extends ProductState {}

class SendProductCommentError extends ProductState {
  final String error;
  SendProductCommentError(this.error);
}

class SendProductCommentLoading extends ProductState {}

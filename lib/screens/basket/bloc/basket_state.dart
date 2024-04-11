part of 'basket_bloc.dart';

@immutable
sealed class BasketState {}

final class BasketInitial extends BasketState {}

//add product to basket

class AddProductToBasketSuccess extends BasketState {}

class AddProductToBasketError extends BasketState {
  final String error;
  AddProductToBasketError(this.error);
}

class AddProductToBasketLoading extends BasketState {}
// get basket

class GetBasketSuccess extends BasketState {
  final Basket basket;
  GetBasketSuccess(this.basket);
}

class GetBasketError extends BasketState {
  final String error;
  GetBasketError(this.error);
}

class GetBasketLoading extends BasketState {}

//Increment

class IncrementProductSuccess extends BasketState {}

class IncrementProductError extends BasketState {
  final String error;
  IncrementProductError(this.error);
}

class IncrementProductLoading extends BasketState {}

//Decrement

class DecrementProductSuccess extends BasketState {}

class DecrementProductError extends BasketState {
  final String error;
  DecrementProductError(this.error);
}

class DecrementProductLoading extends BasketState {}

//Delate Product from Basket

class DeleteProductFromBasketSuccess extends BasketState {}

class DeleteProductFromBasketError extends BasketState {
  final String error;
  DeleteProductFromBasketError(this.error);
}

class DeleteProductFromBasketLoading extends BasketState {}

//Payment

class PaymentSuccess extends BasketState {
  final String getaway;
  PaymentSuccess(this.getaway);
}

class PaymentError extends BasketState {
  final String error;
  PaymentError(this.error);
}

class PaymentLoading extends BasketState {}

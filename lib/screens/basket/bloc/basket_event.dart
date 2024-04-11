part of 'basket_bloc.dart';

@immutable
sealed class BasketEvent {}

class AddProductToBasket extends BasketEvent {
  final int productId;
  AddProductToBasket(this.productId);
}

class BasketPageStarted extends BasketEvent {}

class IncrementProduct extends BasketEvent {
  final int prouctId;
  IncrementProduct(this.prouctId);
}

class DecrementProduct extends BasketEvent {
  final int prouctId;
  DecrementProduct(this.prouctId);
}

class DeleteProductFromBasket extends BasketEvent {
  final int productId;
  DeleteProductFromBasket(this.productId);
}

class PaymentProducts extends BasketEvent {
  final Payment payment;
  PaymentProducts(this.payment);
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vesam_shop/data/modeels/basket.dart';
import 'package:vesam_shop/data/services/basket.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BasketService basketService;
  BasketBloc(this.basketService) : super(BasketInitial()) {
    on<BasketEvent>((event, emit) async {
      // add product to basket
      if (event is AddProductToBasket) {
        emit(AddProductToBasketLoading());
        try {
          await basketService.addBasket(event.productId);
          emit(AddProductToBasketSuccess());
        } catch (e) {
          emit(AddProductToBasketError('خطای نامشخص'));
        }
      }
      //get basket
      if (event is BasketPageStarted) {
        emit(GetBasketLoading());
        try {
          var response = await basketService.getAllBasket();
          emit(GetBasketSuccess(response));
        } catch (e) {
          emit(GetBasketError('خطای نامشخص'));
        }
      }
      //Increment
      if (event is IncrementProduct) {
        emit(IncrementProductLoading());
        try {
          await basketService.increaseProductCount(event.prouctId);
          emit(IncrementProductSuccess());
        } catch (e) {
          emit(IncrementProductError('خطای نامشخص'));
        }
      }

      //Decrement
      if (event is DecrementProduct) {
        emit(DecrementProductLoading());
        try {
          await basketService.decreaseProductCount(event.prouctId);
          emit(DecrementProductSuccess());
        } catch (e) {
          emit(DecrementProductError('خطای نامشخص'));
        }
      }

      //Delate Product From Basket
      if (event is DeleteProductFromBasket) {
        emit(DeleteProductFromBasketLoading());
        try {
          await basketService.deleteProductFromBasket(event.productId);
          emit(DeleteProductFromBasketSuccess());
        } catch (e) {
          emit(DeleteProductFromBasketError('خطای نامشخص'));
        }
      }
      // Payment
      if (event is PaymentProducts) {
        emit(PaymentLoading());
        try {
          var response = await basketService.payment(event.payment);
          emit(PaymentSuccess(response));
        } catch (e) {
          emit(PaymentError('خطای نامشخص'));
        }
      }
    });
  }
}

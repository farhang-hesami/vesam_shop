import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vesam_shop/data/modeels/product.dart';
import 'package:vesam_shop/data/services/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;
  ProductBloc(this.productService) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      //latest
      if (event is LatestProductsPageStarted) {
        emit(GetLatestPrductLoading());

        try {
          var response = await productService.getLatesProducts();
          emit(GetLatestPrductSuccess(response));
        } catch (e) {
          emit(GetLatestPrductError('خطای نامشخص'));
        }
      }
      //popular
      if (event is PopularProductsPageStarted) {
        emit(GetPopularPrductLoading());

        try {
          var response = await productService.getPopularProducts();
          emit(GetPopularPrductSuccess(response));
        } catch (e) {
          emit(GetLatestPrductError('خطای نامشخص'));
        }
      }
      // Detail

      if (event is ProductDetailPageStarted) {
        emit(GetProductDetailLoding());
        try {
          var response = await productService.getDetailProduct(event.productId);
          emit(GetPorductDetailSuccess(response));
        } catch (e) {
          emit(GetProductDetailError('خطا نامشخص'));
        }
      }
      // comment
      if (event is SendProductComment) {
        emit(SendProductCommentLoading());
        try {
          await productService.sendProductComment(event.comments);
          emit(SendProductCommentSuccess());
        } catch (e) {
          emit(SendProductCommentError('خطای نامشخص'));
        }
      }
    });
  }
}

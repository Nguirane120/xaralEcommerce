import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import 'package:ecmmerce/apiservice.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ApiService apiService;

  CartBloc(this.apiService) : super(CartLoading()) {
    on<LoadCart>((event, emit) async {
      emit(CartLoading());
      try {
        final items = await apiService.fetchCart();
        emit(CartLoaded(items));
      } catch (e) {
        emit(CartError('Failed to load cart'));
      }
    });

    // on<AddToCart>((event, emit) async {
    //   try {
    //     await apiService.addItemToCart(event.productId);
    //     final updatedItems = await apiService.fetchCart();
    //     emit(CartLoaded(updatedItems));
    //   } catch (e) {
    //     emit(CartError('Failed to add item to cart'));
    //   }
    // });
  }
}

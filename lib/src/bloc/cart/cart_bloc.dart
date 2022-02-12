import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/src/model/cart_model.dart';
import 'package:shopping_cart/src/model/product_model.dart';
import 'package:shopping_cart/src/repository/shopping_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.repository}) : super(CartLoading()) {
    on<CartStarted>(_onStarted);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
  }

  final Repository repository;

  void _onStarted(CartStarted event, Emitter<CartState> emit) {
    emit(CartLoading());
    try {
      final items = repository.loadCartItems();
      emit(CartLoaded(cart: CartModel(items: [...items])));
    } catch (_) {
      emit(CartError(_.toString()));
    }
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        // repository.addItemToCart(event.item);
        emit(CartLoaded(
            cart: CartModel(items: [...state.cart.items, event.item])));
      } catch (_) {
        emit(CartError(_.toString()));
      }
    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        // repository.removeItemFromCart(event.item);
        emit(
          CartLoaded(
            cart: CartModel(
              items: [...state.cart.items]..remove(event.item),
            ),
          ),
        );
      } catch (_) {
        emit(CartError(_.toString()));
      }
    }
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Repository repository;

  void _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      List<ProductModel> items = await checkDataSourceAndRetrieveData();

      // final items = repository.loadCartItems();
      emit(CartLoaded(cart: CartModel(items: [...items.toList()])));
    } catch (_) {
      emit(CartError(_.toString()));
    }
  }

  Future<List<ProductModel>> checkDataSourceAndRetrieveData() async {
    var items = <ProductModel>[];
    final SharedPreferences prefs = await _prefs;

    if (prefs.getString('cart') != null) {
      List list = json.decode(prefs.getString('cart').toString());
      list = list.map((e) => ProductModel.fromJson(e)).toList();
      for (var element in list) {
        items.add(element);
      }
    } else {
      items = repository.loadCartItems();
    }

    await prefs.setString('cart', jsonEncode(items));
    return items;
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        // repository.addItemToCart(event.item);
        await addToCachedData(state, event);

        emit(CartLoaded(
            cart: CartModel(items: [...state.cart.items, event.item])));
      } catch (_) {
        emit(CartError(_.toString()));
      }
    }
  }

  Future<void> addToCachedData(CartLoaded state, CartItemAdded event) async {
    final SharedPreferences prefs = await _prefs;
    var items = [...state.cart.items, event.item];

    await prefs.setString('cart', jsonEncode(items));
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        // repository.removeItemFromCart(event.item);

        await removeFromCachedData(state, event);

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

  Future<void> removeFromCachedData(
      CartLoaded state, CartItemRemoved event) async {
    final SharedPreferences prefs = await _prefs;
    var items = [...state.cart.items]..remove(event.item);

    await prefs.setString('cart', jsonEncode(items));
  }
}

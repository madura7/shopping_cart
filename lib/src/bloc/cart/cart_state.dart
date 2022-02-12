part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  const CartLoaded({this.cart = const CartModel()});

  final CartModel cart;

  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {
  final String error;

  const CartError(this.error);
  @override
  List<Object> get props => [error];
}

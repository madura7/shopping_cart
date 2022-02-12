import 'package:equatable/equatable.dart';
import 'package:shopping_cart/src/model/product_model.dart';

class CartModel extends Equatable {
  const CartModel({this.items = const <ProductModel>[]});

  final List<ProductModel> items;

  double get totalPrice {
    return items.fold(0, (total, current) => total + current.price);
  }

  @override
  List<Object> get props => [items];
}

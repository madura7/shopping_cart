import 'package:equatable/equatable.dart';
import 'package:shopping_cart/src/model/product_model.dart';

class FavoriteModel extends Equatable {
  const FavoriteModel({this.favorites = const <ProductModel>[]});

  final List<ProductModel> favorites;

  @override
  List<Object> get props => [favorites];
}

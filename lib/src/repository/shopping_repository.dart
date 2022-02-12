import 'package:shopping_cart/src/model/favorite_model.dart';
import 'package:shopping_cart/src/model/product_model.dart';
import 'package:shopping_cart/src/repository/product_repository.dart';

const _delay = Duration(milliseconds: 800);

class Repository {
  final _items = <ProductModel>[];
  final _favorites = <ProductModel>[];
  ProductRepository productRepo = ProductRepository();

  // Product
  Future<ProductFromBackend> getProducts() => productRepo.getProducts();

  // Cart
  List<ProductModel> loadCartItems() => _items;

  void addItemToCart(ProductModel item) => _items.add(item);

  void removeItemFromCart(ProductModel item) => _items.remove(item);

  // favorite
  FavoriteModel loadFavoriteItems() {
    return FavoriteModel(favorites: _favorites);
  }

  void addItemToFavorite(ProductModel item) => _favorites.add(item);

  void removeItemFromFavorite(ProductModel item) => _favorites.remove(item);
}

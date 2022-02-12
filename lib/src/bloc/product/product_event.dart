part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProducts extends ProductEvent {
  const GetProducts();

  @override
  List<Object> get props => [];
}

class FilterProducts extends ProductEvent {
  final String category;

  const FilterProducts(this.category);

  @override
  List<Object> get props => [category];
}

class SearchProducts extends ProductEvent {
  final String searchText;

  const SearchProducts(this.searchText);

  @override
  List<Object> get props => [searchText];
}

part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {
  final String error;

  const ProductError(this.error);
  @override
  List<Object> get props => [error];
}

class ProductLoaded extends ProductState {
  final ProductFromBackend records;
  final ProductFromBackend originalRecords;
  final String searchText;
  final String category;

  const ProductLoaded(
      this.records, this.originalRecords, this.searchText, this.category);
  @override
  List<Object> get props => [records, originalRecords];
}

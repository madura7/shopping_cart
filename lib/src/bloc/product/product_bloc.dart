import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/src/model/product_model.dart';
import 'package:shopping_cart/src/repository/shopping_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._repository) : super(ProductInitial()) {
    on<GetProducts>(_onGetProducts);
  }

  final Repository _repository;

  void _onGetProducts(GetProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await _repository.getProducts();
      emit(ProductLoaded(products));
    } catch (_) {
      emit(ProductError(_.toString()));
    }
  }
}

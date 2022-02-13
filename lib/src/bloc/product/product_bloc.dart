import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart/src/model/product_model.dart';
import 'package:shopping_cart/src/repository/shopping_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._repository) : super(ProductInitial()) {
    on<GetProducts>(_onGetProducts);
    on<FilterProducts>(_onFilterProducts);
    on<SearchProducts>(_onSearchProducts);
  }
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Repository _repository;

  void _onGetProducts(GetProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      ProductFromBackend products = await checkDataSourceAndRetrieveData();

      emit(ProductLoaded(products, products, '', ''));
    } catch (_) {
      emit(ProductError(_.toString()));
    }
  }

  Future<ProductFromBackend> checkDataSourceAndRetrieveData() async {
    final SharedPreferences prefs = await _prefs;

    var products = prefs.getString('products') != null
        ? ProductFromBackend.fromJson(
            json.decode(prefs.getString('products').toString()))
        : await _repository.getProducts();

    await prefs.setString('products', jsonEncode(products.toJson()));
    return products;
  }

  void _onFilterProducts(
      FilterProducts event, Emitter<ProductState> emit) async {
    // emit(ProductLoading());
    try {
      // var products = await _repository.getProducts();
      final state = this.state;

      if (state is ProductLoaded) {
        var products = ProductFromBackend(
            status: true, result: state.originalRecords.result);


        if (state.searchText != "" || event.category != "") {
          if (event.category != "") {
            // filter by category
            products = filterByCategory(products, event);
          }
          if (state.searchText != "") {
            // search by model
            // products = searchByModel(products, event);
          }
        }

        emit(ProductLoaded(
          products,
          state.originalRecords,
          state.searchText,
          state.category,
        ));
      }
    } catch (_) {
      emit(ProductError(_.toString()));
    }
  }

  void _onSearchProducts(
      SearchProducts event, Emitter<ProductState> emit) async {
    // emit(ProductLoading());
    try {
      // var products = await _repository.getProducts();
      final state = this.state;

      if (state is ProductLoaded) {
        var products = ProductFromBackend(
            status: true, result: state.originalRecords.result);

        if (event.searchText != "" || state.category != "") {
          if (state.category != "") {
            // filter by category
            // products = filterByCategory(products, event);
          }
          if (event.searchText != "") {
            // search by model
            products = searchByModel(products, event);
          }
        }

        emit(ProductLoaded(
          products,
          state.originalRecords,
          state.searchText,
          state.category,
        ));
      }
    } catch (_) {
      emit(ProductError(_.toString()));
    }
  }

  ProductFromBackend filterByCategory(
      ProductFromBackend products, FilterProducts event) {
    return ProductFromBackend(
        status: true,
        result: products.result
            .where((a) => a.category == event.category)
            .toList());
  }

  ProductFromBackend searchByModel(
      ProductFromBackend products, SearchProducts event) {
    var list = products.result
        .where((a) =>
            a.model.toUpperCase().contains(event.searchText.toUpperCase()))
        .toList();
    return ProductFromBackend(status: true, result: list);
  }
}

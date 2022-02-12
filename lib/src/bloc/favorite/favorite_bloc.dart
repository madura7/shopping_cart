import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/src/model/favorite_model.dart';
import 'package:shopping_cart/src/model/product_model.dart';
import 'package:shopping_cart/src/repository/shopping_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({required this.repository}) : super(FavoriteLoading()) {
    on<FavoriteStarted>(_onStarted);
    on<FavoriteItemToggle>(_onItemFavoriteToggle);
  }

  final Repository repository;

  void _onStarted(FavoriteStarted event, Emitter<FavoriteState> emit) {
    emit(FavoriteLoading());
    try {
      final favorites = repository.loadFavoriteItems();
      emit(FavoriteLoaded(items: favorites));
    } catch (_) {
      emit(FavoriteError(_.toString()));
    }
  }

  void _onItemFavoriteToggle(
      FavoriteItemToggle event, Emitter<FavoriteState> emit) async {
    final state = this.state;
    if (state is FavoriteLoaded) {
      try {
        if (state.items.favorites
            .map((item) => item.model)
            .contains(event.item.model)) {
          // repository.removeItemFromFavorite(event.item);
          emit(
            FavoriteLoaded(
              items: FavoriteModel(
                favorites: [...state.items.favorites]..remove(event.item),
              ),
            ),
          );
        } else {
          // repository.addItemToFavorite(event.item);
          emit(FavoriteLoaded(
              items: FavoriteModel(
                  favorites: [...state.items.favorites, event.item])));
        }
      } catch (_) {
        emit(FavoriteError(_.toString()));
      }
    }
  }
}

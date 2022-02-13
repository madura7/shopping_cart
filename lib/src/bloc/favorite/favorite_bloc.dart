import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Repository repository;

  void _onStarted(FavoriteStarted event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      final SharedPreferences prefs = await _prefs;

      FavoriteModel favorites = checkDataSourceAndRetriveData(prefs);

      emit(FavoriteLoaded(items: favorites));
    } catch (_) {
      emit(FavoriteError(_.toString()));
    }
  }

  FavoriteModel checkDataSourceAndRetriveData(SharedPreferences prefs) {
    // ignore: prefer_const_constructors
    var favorites = FavoriteModel(favorites: []);
    if (prefs.getString('favorite') != null) {
      List list = json.decode(prefs.getString('favorite').toString());
      list = list.map((e) => ProductModel.fromJson(e)).toList();
      for (var element in list) {
        favorites.favorites.add(element);
      }
    } else {
      favorites = repository.loadFavoriteItems();
    }
    return favorites;
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
          await removeFromCachedData(state, event);

          emit(
            FavoriteLoaded(
              items: FavoriteModel(
                favorites: [...state.items.favorites]
                  ..removeWhere((item) => item.model == event.item.model),
              ),
            ),
          );
        } else {
          // repository.addItemToFavorite(event.item);
          await addToCachedData(state, event);

          emit(FavoriteLoaded(
              items: FavoriteModel(
                  favorites: [...state.items.favorites, event.item])));
        }
      } catch (_) {
        emit(FavoriteError(_.toString()));
      }
    }
  }

  Future<void> addToCachedData(
      FavoriteLoaded state, FavoriteItemToggle event) async {
    final SharedPreferences prefs = await _prefs;
    var items = [...state.items.favorites, event.item];
    await prefs.setString('favorite', jsonEncode(items));
  }

  Future<void> removeFromCachedData(
      FavoriteLoaded state, FavoriteItemToggle event) async {
    final SharedPreferences prefs = await _prefs;
    var items = [...state.items.favorites]
      ..removeWhere((item) => item.model == event.item.model);
    await prefs.setString('favorite', jsonEncode(items));
  }
}

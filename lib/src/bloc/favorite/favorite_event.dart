part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FavoriteStarted extends FavoriteEvent {
  @override
  List<Object> get props => [];
}

class FavoriteItemToggle extends FavoriteEvent {
  const FavoriteItemToggle(this.item);

  final ProductModel item;

  @override
  List<Object> get props => [item];
}

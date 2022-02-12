part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteLoading extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoaded extends FavoriteState {
  const FavoriteLoaded({required this.items});

  final FavoriteModel items;

  @override
  List<Object> get props => [items];
}

class FavoriteError extends FavoriteState {
  final String error;

  const FavoriteError(this.error);
  @override
  List<Object> get props => [error];
}

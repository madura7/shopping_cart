import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/src/bloc/cart/cart_bloc.dart';
import 'package:shopping_cart/src/bloc/favorite/favorite_bloc.dart';
import 'package:shopping_cart/src/bloc/product/product_bloc.dart';
import 'package:shopping_cart/src/model/category_model.dart';
import 'package:shopping_cart/src/presentation/screens/home/home_page_ui.dart';
import 'package:shopping_cart/src/repository/shopping_repository.dart';
import 'package:shopping_cart/src/resources/simple_bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp(repository: Repository())),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.repository}) : super(key: key);
  final Repository repository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductBloc(repository)..add(const GetProducts()),
        ),
        BlocProvider(
          create: (_) => CartBloc(
            repository: repository,
          )..add(CartStarted()),
        ),
        BlocProvider(
          create: (_) => FavoriteBloc(
            repository: repository,
          )..add(
              FavoriteStarted(),
            ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bliss',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          create: (_) => CategoryNotifierModel(),
          child: const HomePageUI(),
        ),
      ),
    );
  }
}

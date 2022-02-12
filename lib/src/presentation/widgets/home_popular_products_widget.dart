import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/bloc/favorite/favorite_bloc.dart';
import 'package:shopping_cart/src/bloc/product/product_bloc.dart';
import 'package:shopping_cart/src/presentation/screens/product/product_detail_ui.dart';
import 'package:shopping_cart/src/resources/constants.dart';

class HomePopularProductsWidget extends StatefulWidget {
  const HomePopularProductsWidget({Key? key}) : super(key: key);

  @override
  State<HomePopularProductsWidget> createState() =>
      _HomePopularProductsWidgetState();
}

class _HomePopularProductsWidgetState extends State<HomePopularProductsWidget> {
  List<String> productList = List<String>.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Most Popular",
              style: TextStyle(
                color: kSecondaryTextColor,
                fontSize: lgTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              const CircularProgressIndicator();
            }
            if (state is ProductLoaded) {
              return SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.records.result.length,
                  itemBuilder: (conttext, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => ProductDetailUI(
                              productModel: state.records.result[i],
                              backgroundColor: i % 2 == 1
                                  ? kCardBackgroundColor1
                                  : kCardBackgroundColor2,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            // side: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          elevation: 3,
                          color: i % 2 == 1
                              ? kCardBackgroundColor1
                              : kCardBackgroundColor2,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 4),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        state.records.result[i].model,
                                        style: const TextStyle(
                                          fontSize: mdTextSize,
                                          fontWeight: FontWeight.bold,
                                          color: kSecondaryTextColor,
                                        ),
                                      ),
                                      const Spacer(),
                                      BlocBuilder<FavoriteBloc, FavoriteState>(
                                        builder: (context, favoriteState) {
                                          if (favoriteState is FavoriteLoaded) {
                                            final liked = favoriteState
                                                .items.favorites
                                                .contains(
                                                    state.records.result[i]);
                                            return IconButton(
                                              onPressed: () {
                                                context
                                                    .read<FavoriteBloc>()
                                                    .add(
                                                      FavoriteItemToggle(
                                                        state.records.result[i],
                                                      ),
                                                    );
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: liked
                                                    ? Colors.red
                                                    : Colors.white,
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      )
                                    ],
                                  ),

                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/guitar.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  // CachedNetworkImage(
                                  //   imageUrl:
                                  //       "https://www.stars-music.com/medias/fender/strat-player-mex-sss-mn-600-146099.jpg",
                                  //   width: 150,
                                  //   height: 150,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox(
                child: Center(child: Text("No Data Found")),
              );
            }
          },
        ),
      ],
    );
  }
}

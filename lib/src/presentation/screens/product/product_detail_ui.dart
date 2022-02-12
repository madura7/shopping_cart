import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/bloc/cart/cart_bloc.dart';
import 'package:shopping_cart/src/bloc/favorite/favorite_bloc.dart';
import 'package:shopping_cart/src/model/product_model.dart';
import 'package:shopping_cart/src/presentation/screens/cart/cart_page_ui.dart';
import 'package:shopping_cart/src/resources/constants.dart';

class ProductDetailUI extends StatefulWidget {
  const ProductDetailUI(
      {Key? key, required this.backgroundColor, required this.productModel})
      : super(key: key);
  final Color backgroundColor;
  final ProductModel productModel;

  @override
  State<ProductDetailUI> createState() => _ProductDetailUIState();
}

class _ProductDetailUIState extends State<ProductDetailUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomSheet(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.backgroundColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, favoriteState) {
              if (favoriteState is FavoriteLoaded) {
                final liked = favoriteState.items.favorites
                    .map((item) => item.model)
                    .contains(widget.productModel.model);

                return IconButton(
                  onPressed: () {
                    context.read<FavoriteBloc>().add(
                          FavoriteItemToggle(
                            widget.productModel,
                          ),
                        );
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: liked ? Colors.red : Colors.white,
                  ),
                );
              }

              return IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite));
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const CartPageUI(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: widget.backgroundColor,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 80,
              height: (MediaQuery.of(context).size.height * 0.60) - 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      widget.productModel.image), // "assets/images/guitar.png"
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // CachedNetworkImage(
            //   imageUrl: widget.productModel.image,
            //   width: MediaQuery.of(context).size.width - 80,
            //   height: (MediaQuery.of(context).size.height * 0.60) - 100,
            // ),
          ],
        ),
      ),
    );
  }

  BottomAppBar bottomSheet(BuildContext context) {
    return BottomAppBar(
      color: widget.backgroundColor,
      child: Container(
        decoration: const BoxDecoration(
          color: kContainerBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.4,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      widget.productModel.model,
                      style: const TextStyle(
                        color: kSecondaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: xlTextSize,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                productDetailContent("Brand", widget.productModel.brand),
                productDetailContent(
                    "Price", widget.productModel.price.toString()),
                productDetailContent("Color", widget.productModel.colour),
                productDetailContent("Weight", widget.productModel.weight),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryTextColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(CartItemAdded(widget.productModel));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      elevation: 3,
    );
  }

  Row productDetailContent(String key, String value) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            key,
            style: const TextStyle(
              color: kSecondaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: mdTextSize,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              value,
              style: const TextStyle(
                color: kSecondaryTextColor,
                fontSize: mdTextSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

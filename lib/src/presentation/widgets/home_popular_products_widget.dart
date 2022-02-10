import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

    productList.add("value");
    productList.add("value");
    productList.add("value");
    productList.add("value");
    productList.add("value");
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
        SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (conttext, i) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => ProductDetailUI(
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
                                const Text(
                                  "STT007",
                                  style: TextStyle(
                                    fontSize: mdTextSize,
                                    fontWeight: FontWeight.bold,
                                    color: kSecondaryTextColor,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),

                            Container(
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/guitar.png"),
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
        ),
      ],
    );
  }
}

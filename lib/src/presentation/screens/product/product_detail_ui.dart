import 'package:flutter/material.dart';
import 'package:shopping_cart/src/presentation/screens/cart/cart_page_ui.dart';
import 'package:shopping_cart/src/resources/constants.dart';

class ProductDetailUI extends StatefulWidget {
  const ProductDetailUI({Key? key, required this.backgroundColor})
      : super(key: key);
  final Color backgroundColor;

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/guitar.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                  children: const [
                    Text(
                      "OCCC112",
                      style: TextStyle(
                        color: kSecondaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: xlTextSize,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                productDetailContent("Brand", "Yamaha Yamaha "),
                productDetailContent("Price", "299.00"),
                productDetailContent("Color", "Red"),
                productDetailContent("Weight", "2.3 Kg"),
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
                    onPressed: () {},
                  ),
                )
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
              fontSize: lgTextSize,
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
                fontSize: lgTextSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

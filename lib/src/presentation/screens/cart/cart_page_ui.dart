import 'package:flutter/material.dart';
import 'package:shopping_cart/src/resources/constants.dart';

class CartPageUI extends StatefulWidget {
  const CartPageUI({Key? key}) : super(key: key);

  @override
  State<CartPageUI> createState() => _CartPageUIState();
}

class _CartPageUIState extends State<CartPageUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: const Text(
                        "BLISS",
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontSize: xxlTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  color: kBackgroundColor,
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height * 0.9) - 100,
                  child: Center(
                      child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        height: 130,
                        width: 130,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/cart.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text(
                        "Your Cart is currently empty !",
                        style: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: lgTextSize,
                        ),
                      ),
                      const Spacer(),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

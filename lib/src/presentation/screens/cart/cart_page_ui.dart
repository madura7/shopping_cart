import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/bloc/cart/cart_bloc.dart';
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
                  children: const [
                    SizedBox(
                      height: 50,
                      child: Text(
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
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is CartLoaded) {
                      if (state.cart.items.isNotEmpty) {
                        return cartData(context, state);
                      } else {
                        return cartEmpty(context);
                      }
                    } else {
                      return cartEmpty(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container cartEmpty(BuildContext context) {
    return Container(
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * 0.1),
            child: Column(
              children: [
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
                      'Browse items',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  Column cartData(BuildContext context, CartLoaded state) {
    return Column(
      children: [
        SizedBox(
          height: (MediaQuery.of(context).size.height * 0.7) - 100,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.cart.items.length,
            itemBuilder: (conttext, i) {
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        color: i % 2 == 1
                            ? kCardBackgroundColor1
                            : kCardBackgroundColor2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(state.cart.items[i]
                                      .image), // "assets/images/guitar.png"
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 220,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.cart.items[i].brand,
                                  style: const TextStyle(
                                    fontSize: lgTextSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  currency +
                                      state.cart.items[i].price.toString(),
                                  style: const TextStyle(
                                    fontSize: lgTextSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<CartBloc>()
                                    .add(CartItemRemoved(state.cart.items[i]));
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.height * 0.3),
          child: Column(
            children: [
              cartTotal(state),
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
                    'Check out',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column cartTotal(CartLoaded state) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5, left: 8.0, right: 8.0),
          child: Divider(
            color: kPrimaryTextColor,
            thickness: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Row(
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  color: kSecondaryTextColor,
                  fontSize: lgTextSize,
                ),
              ),
              const Spacer(),
              Text(
                currency + state.cart.totalPrice.toString(),
                style: const TextStyle(
                  color: kSecondaryTextColor,
                  fontSize: lgTextSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

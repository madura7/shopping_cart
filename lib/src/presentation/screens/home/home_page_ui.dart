import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/bloc/product/product_bloc.dart';
import 'package:shopping_cart/src/model/category_model.dart';
import 'package:shopping_cart/src/presentation/widgets/home_category_widget.dart';
import 'package:shopping_cart/src/presentation/widgets/home_popular_products_widget.dart';
import 'package:shopping_cart/src/presentation/widgets/home_welcome_widget.dart';
import 'package:shopping_cart/src/resources/constants.dart';

class HomePageUI extends StatefulWidget {
  const HomePageUI({Key? key}) : super(key: key);

  @override
  State<HomePageUI> createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  @override
  void initState() {
    super.initState();

    categoryList.clear();
    categoryList
        .add(CategoryModel(value: "guitar", color: const Color(0xffFE8EA3)));
    categoryList
        .add(CategoryModel(value: "piano", color: const Color(0xffFED978)));
    categoryList
        .add(CategoryModel(value: "drums", color: const Color(0xffA7ECC6)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            color: kBackgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const HomeWelcomeWidget(),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.search,
                          color: kPrimaryTextColor,
                        ),
                        hintText: 'Search Your Model',
                        hintStyle: TextStyle(
                            color: kSecondaryTextColor.withOpacity(0.6)),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onChanged: (value) {
                      context.read<ProductBloc>().add(
                            SearchProducts(value),
                          );
                    },
                  ),
                  const SizedBox(height: 50),
                  HomeCategoryWidget(
                    categoryList: categoryList,
                  ),
                  const SizedBox(height: 50),
                  const HomePopularProductsWidget(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

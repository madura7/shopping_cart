import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/bloc/product/product_bloc.dart';
import 'package:shopping_cart/src/model/category_model.dart';
import 'package:shopping_cart/src/resources/constants.dart';

class HomeCategoryWidget extends StatefulWidget {
  const HomeCategoryWidget({Key? key, required this.categoryList})
      : super(key: key);
  final List<CategoryModel> categoryList;
  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
  var selectedCategory = "";
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
              "By Category",
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
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categoryList.length,
            itemBuilder: (conttext, i) {
              return InkWell(
                onTap: () {
                  setState(() {
                    if (selectedCategory != widget.categoryList[i].value) {
                      selectedCategory = widget.categoryList[i].value;
                    } else {
                      selectedCategory = "";
                    }
                  });

                  context.read<ProductBloc>().add(
                        FilterProducts(selectedCategory),
                      );
                },
                child: SizedBox(
                  width: 150,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      // side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 3,
                    // color: const Color.fromARGB(255, 55, 119, 179),
                    color: widget.categoryList[i].color,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            Icon(
                              CupertinoIcons.guitars,
                              color: selectedCategory ==
                                      widget.categoryList[i].value
                                  ? const Color.fromARGB(255, 65, 60, 60)
                                  : Colors.white,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              widget.categoryList[i].value.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: mdTextSize,
                                fontWeight: FontWeight.w800,
                                color: selectedCategory ==
                                        widget.categoryList[i].value
                                    ? const Color.fromARGB(255, 65, 60, 60)
                                    : Colors.white,
                              ),
                            ),
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

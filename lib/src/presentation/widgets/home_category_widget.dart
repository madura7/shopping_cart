import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/src/resources/constants.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({
    Key? key,
    required this.categoryList,
  }) : super(key: key);

  final List<String> categoryList;

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
            itemCount: categoryList.length,
            itemBuilder: (conttext, i) {
              return InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 150,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 3,
                    color: const Color.fromARGB(255, 55, 119, 179),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            const Icon(
                              CupertinoIcons.guitars,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 25),
                            Text(
                              categoryList[i].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: mdTextSize,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
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

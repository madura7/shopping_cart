import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/src/resources/constants.dart';

class HomeWelcomeWidget extends StatelessWidget {
  const HomeWelcomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "BLISS",
              style: TextStyle(
                color: kPrimaryTextColor,
                fontSize: xxlTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: userImage,
                width: 80,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Hello,",
              style: TextStyle(
                color: kSecondaryTextColor.withOpacity(0.8),
                fontSize: xxlTextSize,
              ),
            ),
          ],
        ),
        Row(
          children: const [
            Text(
              "Sudesh Kumara",
              style: TextStyle(
                color: kSecondaryTextColor,
                fontSize: xxlTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

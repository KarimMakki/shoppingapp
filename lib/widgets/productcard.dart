import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  const ProductCard(
      {super.key,
      required this.name,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        margin: const EdgeInsets.all(0),
        color: Colors.white,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 250,
                width: 250,
                child: FadeInImage.assetNetwork(
                  image: image,
                  placeholder: "assets/images/placeholder.png",
                  fadeInDuration: const Duration(milliseconds: 10),
                )),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                name,
                textAlign: TextAlign.start,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    textAlign: TextAlign.right,
                  ),
                  const Text(
                    "SDG",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

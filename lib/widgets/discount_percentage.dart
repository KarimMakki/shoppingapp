import 'package:flutter/material.dart';
import 'package:shopping_app/models/product_model.dart';

import '../services/getDiscountPercentage.dart';

class DiscountPercentageBox extends StatelessWidget {
  final String? regularPrice;
  final String? salePrice;
  final Product product;
  const DiscountPercentageBox(
      {super.key,
      required this.regularPrice,
      required this.salePrice,
      required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.on_sale == true) {
      return Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "${getDiscountPercentage(double.tryParse(product.sale_price.toString()), double.tryParse(product.regular_price.toString())).toStringAsFixed(0).toString()}%",
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

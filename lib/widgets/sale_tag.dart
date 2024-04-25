import 'package:flutter/material.dart';

import '../models/product_model.dart';

class SaleTag extends StatelessWidget {
  final Product product;
  const SaleTag({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.on_sale == true) {
      return Container(
        margin: const EdgeInsets.only(right: 6, left: 8, bottom: 17),
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Sale",
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    return Container();
  }
}

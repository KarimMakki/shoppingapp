import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/bottom_sheet.dart';
import '../constants.dart';
import '../models/attribute_model.dart';
import '../models/product_model.dart';

class BottomProductButtons extends StatelessWidget {
  const BottomProductButtons({
    super.key,
    required this.productattributes,
    required this.product,
  });

  final List<Attribute> productattributes;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: MaterialButton(
                height: 42,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16))),
                    builder: (context) {
                      return ProductDetailsBottomSheet(
                        product: product,
                        productattributes: productattributes,
                        isBuyNow: false,
                      );
                    },
                  );
                },
                color: kPrimaryColor,
                child: const Row(
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.60,
              child: MaterialButton(
                height: 42,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ProductDetailsBottomSheet(
                        product: product,
                        productattributes: productattributes,
                        isBuyNow: true,
                      );
                    },
                  );
                },
                color: Colors.black,
                child: const Text("Buy Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

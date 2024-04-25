import 'package:flutter/material.dart';
import 'package:shopping_app/models/cart_item_model.dart';

class OrderItem extends StatelessWidget {
  final CartItem cartItem;
  const OrderItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: SizedBox(
                  width: constraints.maxWidth * 0.18,
                  height: constraints.maxWidth * 0.18,
                  child: Image.network(
                      cartItem.variation?.featuredImage.toString() ??
                          cartItem.productImage.toString()),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.7,
                    child: Text(
                      cartItem.productName!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "${cartItem.productPrice!}SDG",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.7,
                    child: Row(
                      children: [
                        if (cartItem.productVariant != null)
                          Text("Variation: ${cartItem.productVariant!}"),
                        const Spacer(),
                        Text("x${cartItem.quantity.toString()}")
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

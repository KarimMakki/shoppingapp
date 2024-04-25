import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/screens/order_details.dart';
import 'package:shopping_app/widgets/custom_divider.dart';
import '../models/order_model.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OrderDetailsPage(order: order),
      )),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Text("Order No:${order.id!}"),
                    const Spacer(),
                    Text(
                      order.status!.toUpperCase(),
                      style: const TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: SizedBox(
                        width: constraints.maxWidth * 0.18,
                        height: constraints.maxWidth * 0.18,
                        child: Image.network(order.lineItems![0].productImage ??
                            order.lineItems![0].product!.images![0].src),
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
                            order.lineItems![0].productName!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.7,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(order.lineItems![0].productVariant!),
                              const Spacer(),
                              Text(
                                "x${order.lineItems![0].quantity.toString()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "${order.lineItems![0].productPrice}SDG",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.9,
                  child: Row(
                    children: [
                      Text(
                        "${order.lineItems?.length} items",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Text(
                            "Order total:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${order.total}SDG",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View all items",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey[700],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomDivider()
              ],
            ),
          );
        },
      ),
    );
  }
}

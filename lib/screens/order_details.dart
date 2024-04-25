import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/order_model.dart';
import '../widgets/custom_divider.dart';
import '../widgets/related_products.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;
  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var merchandiseTotal = order.lineItems!.fold(0, (sum, item) {
      var totalofItems = double.parse(item.getTotal);
      var totalWithDiscount = sum + totalofItems.toInt();
      return totalWithDiscount;
    });
    if (order.couponLines != null) {
      merchandiseTotal =
          merchandiseTotal + order.couponLines![0].amount!.toInt();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Order Details"),
          elevation: 1,
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        "Shipping & Delivery information",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${order.shipping!.firstName} ${order.shipping?.lastName}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          order.shipping!.phoneNo!,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 6),
                        Text(
                            "${order.shipping!.address1!} ${order.shipping!.address2!}",
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 6),
                        Text(order.shipping!.countryName!,
                            style: const TextStyle(fontSize: 16))
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemCount: order.lineItems!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return LayoutBuilder(
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8),
                                      child: SizedBox(
                                        width: constraints.maxWidth * 0.18,
                                        height: constraints.maxWidth * 0.18,
                                        child: Image.network(order
                                                .lineItems![index]
                                                .productImage ??
                                            order.lineItems![index].product!
                                                .images![index].src),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Padding(padding: EdgeInsets.all(8)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: constraints.maxWidth * 0.7,
                                          child: Text(
                                            order
                                                .lineItems![index].productName!,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                              Text(
                                                order.lineItems![index]
                                                    .productVariant!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "x${order.lineItems![index].quantity.toString()}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                          "${order.lineItems![index].product!.price!}SDG",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kPrimaryColor),
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
                                const CustomDivider()
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Merchandise total: ",
                          style: TextStyle(fontSize: 15)),
                      Text(
                        "${merchandiseTotal}SDG",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Shipping fees: ",
                          style: TextStyle(fontSize: 15)),
                      Text(
                        "${order.shippingTotal}SDG",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Coupon discount: ",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "-${order.couponLines![0].amount}SDG",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Order Total: ",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${order.total}SDG",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "You may also like",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          RelatedProducts(product: order.lineItems![0].product!),
        ]));
  }
}

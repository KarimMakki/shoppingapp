import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/widgets/custom_divider.dart';
import 'package:shopping_app/widgets/edit_quantity_button.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            final isSelected =
                cartProvider.selectedCartItems.contains(cartItem);
            return Slidable(
              endActionPane: ActionPane(
                  extentRatio: 0.3,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        cartProvider.deleteCartItemfromDb(cartItem);
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 17.0),
                        child: Checkbox(
                          activeColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          value: isSelected,
                          onChanged: (value) {
                            if (value == true) {
                              cartProvider.addItemtoSelectedCartItems(cartItem);
                            } else {
                              cartProvider
                                  .removeItemtoSelectedCartItems(cartItem);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.20,
                        height: constraints.maxWidth * 0.2,
                        child: Image.network(
                            cartItem.variation?.featuredImage.toString() ??
                                cartItem.productImage.toString()),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.63,
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: Text(
                                  cartItem.productName.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("SDG${cartItem.productPrice.toString()}"),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              cartItem.productVariant ?? "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                ),
                                EditQuantityButton(
                                  counter: cartItem.quantity!,
                                  onChanged: (value) {
                                    cartProvider.updateQuantityonDb(
                                        cartItem, value);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const CustomDivider()
                ],
              ),
            );
          },
        );
      },
    );
  }
}

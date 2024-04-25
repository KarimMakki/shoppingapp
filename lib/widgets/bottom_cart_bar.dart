import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/screens/checkout.dart';
import 'package:shopping_app/widgets/error_message_dialog.dart';

class BottomCartBar extends StatelessWidget {
  const BottomCartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        var formattedtotalPrice =
            NumberFormat('#,##0').format(cartProvider.totalPrice);
        bool isAllSelected = cartProvider.cartItemsFromDb.length ==
            cartProvider.selectedCartItems.length;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Offset in x and y direction
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.088,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  activeColor: kPrimaryColor,
                  value: isAllSelected,
                  onChanged: (value) {
                    if (value == true) {
                      cartProvider.addAllItemtoSelectedCartItems();
                    } else {
                      cartProvider.clearAllItemtoSelectedCartItems();
                    }
                  },
                ),
                const Text("All"),
                const Spacer(),
                Row(
                  children: [
                    const Text("Total: SDG"),
                    Text(
                      formattedtotalPrice,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 28.0, left: 5, bottom: 5),
                  child: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        onPressed: () {
                          if (value.selectedCartItems.isEmpty) {
                            errorMessageDialog(
                                "Please choose some items first!", context);
                          } else {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: const CheckoutPage(),
                                withNavBar: false);
                          }
                        },
                        color: kPrimaryColor,
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

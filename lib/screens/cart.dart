import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/widgets/appbars/cart_appbar.dart';
import 'package:shopping_app/widgets/bottom_cart_bar.dart';
import 'package:shopping_app/widgets/cart_item.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import 'authentication/login.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var user = userbox.get(1);
  @override
  Widget build(BuildContext context) {
    if (userbox.isEmpty) {
      // If the user is not logged in, navigate to LoginPage
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });

      return Container(); // Return an empty container temporarily
    }
    return Scaffold(
      appBar: cartAppBar(context),
      bottomSheet: const BottomCartBar(),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return StreamBuilder<DocumentSnapshot>(
            stream: userDatabase.doc(user!.userEmail).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                if (data["cartItems"] != null) {
                  if (data["cartItems"].isNotEmpty) {
                    final cartItemsMap = data['cartItems'] as List<dynamic>;
                    value.cartItemsFromDb = cartItemsMap
                        .map((e) => CartItem.fromFireStoreJson(e))
                        .toList();
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: value.cartItemsFromDb.length,
                            itemBuilder: (context, index) {
                              final cartItem = value.cartItemsFromDb[index];

                              return CartItemCard(cartItem: cartItem);
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.075,
                        )
                      ],
                    );
                  }
                }
              }

              return LayoutBuilder(builder: (context, constraints) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: constraints.maxHeight * 0.18,
                          child: Image.asset(
                            "assets/images/emptycart.png",
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Your cart is empty!",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}

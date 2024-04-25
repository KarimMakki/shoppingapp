import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/providers/shipping_addresses_provider.dart';
import 'package:shopping_app/providers/wishlist_provider.dart';
import 'package:shopping_app/screens/authentication/login.dart';
import 'package:shopping_app/screens/authentication/register.dart';
import 'package:shopping_app/services/firebase_auth_methods.dart';
import 'package:shopping_app/services/wordpress_auth_methods.dart';
import '../../constants.dart';
import '../../screens/cart.dart';
import 'package:badges/badges.dart' as badges;

import '../../screens/mainpage.dart';

class ProfileSliverAppBar extends StatefulWidget {
  const ProfileSliverAppBar({
    super.key,
  });

  @override
  State<ProfileSliverAppBar> createState() => _ProfileSliverAppBarState();
}

class _ProfileSliverAppBarState extends State<ProfileSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    var user = userbox.get(1);
    return SliverAppBar(
      toolbarHeight: 130,
      backgroundColor: kPrimaryColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 75),
          child: Row(
            children: [
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return badges.Badge(
                    onTap: () => PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const CartPage(),
                        withNavBar: false),
                    position: badges.BadgePosition.custom(start: 25, top: 10),
                    badgeStyle: const badges.BadgeStyle(
                        padding: EdgeInsets.all(4), badgeColor: Colors.white),
                    badgeContent: Text(
                      cartProvider.cartItemsFromDb.length.toString(),
                      style: const TextStyle(color: kPrimaryColor),
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        color: Colors.white,
                        onPressed: () =>
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: const CartPage(), withNavBar: false)),
                  );
                },
              ),
            ],
          ),
        )
      ],
      leadingWidth: MediaQuery.of(context).size.width,
      leading: Padding(
        padding: const EdgeInsets.only(top: 35.0, left: 10),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon((Icons.person), color: Colors.black),
            ),
            const SizedBox(
              width: 7,
            ),
            userbox.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: const LoginPage(), withNavBar: false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: const RegisterPage(),
                                  withNavBar: false);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            child: const Text(
                              "Register Now",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello ${user?.userEmail ?? ""}!",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              FirebaseAuthMethods().signUserOut();
                              await WordpressAuthMethods().clearUser();
                              Provider.of<WishlistProvider>(context,
                                      listen: false)
                                  .clearWishlist();
                              Provider.of<CartProvider>(context, listen: false)
                                  .clearAllItemtoSelectedCartItems();
                              Provider.of<CartProvider>(context, listen: false)
                                  .cartItemsFromDb
                                  .clear();
                              Provider.of<ShippingAddressesProvider>(context,
                                      listen: false)
                                  .selectedshippingAddress = null;
                              PersistentNavBarNavigator.pushNewScreen(context,
                                  screen: MainPage(), withNavBar: false);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("Logged out successfully!"),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
